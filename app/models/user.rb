class User < ActiveRecord::Base
  has_many :friends
  has_many :deletions
  validates :fbid, :uniqueness => true, :on => :create
end
