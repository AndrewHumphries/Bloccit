class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  attr_accessible :body, :title, :topic 
  has_many :coments

  default_scope order('created_at DESC')
end
