class User < ActiveRecord::Base
  has_and_belongs_to_many :tasks
  validates :name, presence: true
  validates :password, presence: true
end
