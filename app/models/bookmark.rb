# == Schema Information
#
# Table name: bookmarks
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  movie_id   :integer
#  user_id    :integer
#
class Bookmark < ApplicationRecord
belongs_to(:movie_name, {
    :class_name => "Movie",
    :foreign_key => "movie_id",
    :required => true
  })

belongs_to(:user)

end
