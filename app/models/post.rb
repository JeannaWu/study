class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 140 }
 

  private

 
  
  
end
