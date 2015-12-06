class Post < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 140 }
end
