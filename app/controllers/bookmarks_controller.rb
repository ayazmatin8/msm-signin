class BookmarksController < ApplicationController
  def index
    @bookmarklist = Bookmark.all
    matching_bookmarks = Bookmark.where({ :user_id => @current_user.id })

    @all_movies = Movie.all

    @movie_bookmarked = matching_bookmarks.map_relation_to_array( :movie_id )

    @matching_movies = @all_movies.where.not( :id => @movie_bookmarked )

    @list_of_bookmarks = matching_bookmarks.order({ :created_at => :desc })


      
    unmatching_bookmarks = Bookmark.where.not({ :user_id =>  @current_user.id })

    @list_of_unbookmarks = unmatching_bookmarks.order({ :created_at => :desc })

    @unique_list = @bookmarklist - @list_of_bookmarks


    render({ :template => "bookmarks/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_bookmarks = Bookmark.where({ :id => the_id })

    @the_bookmark = matching_bookmarks.at(0)

    render({ :template => "bookmarks/show.html.erb" })
  end

  def create
    the_bookmark = Bookmark.new
    the_bookmark.user_id = @current_user.id
    the_bookmark.movie_id = params.fetch("query_movie_id")

    if the_bookmark.valid?
      the_bookmark.save
      redirect_to("/bookmarks", { :notice => "Bookmark created successfully." })
    else
      redirect_to("/bookmarks", { :notice => "Bookmark failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_bookmark = Bookmark.where({ :id => the_id }).at(0)

    the_bookmark.user_id = params.fetch("query_user_id")
    the_bookmark.movie_id = params.fetch("query_movie_id")

    if the_bookmark.valid?
      the_bookmark.save
      redirect_to("/bookmarks/#{the_bookmark.id}", { :notice => "Bookmark updated successfully."} )
    else
      redirect_to("/bookmarks/#{the_bookmark.id}", { :alert => "Bookmark failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_bookmark = Bookmark.where({ :id => the_id }).at(0)

    the_bookmark.destroy

    redirect_to("/bookmarks", { :notice => "Bookmark deleted successfully."} )
  end
end
