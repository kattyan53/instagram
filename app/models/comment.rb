class Comment < ApplicationRecord
  belongs_to :blogs
  belongs_to :user
end
