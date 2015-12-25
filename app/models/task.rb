class Task < ActiveRecord::Base
  has_and_belongs_to_many :users
  validates :description, presence: true

  def status
    fulfiller = User.where(id: self.fulfilled).first
    self.completed ? "выполнил #{fulfiller ? fulfiller.name : 'удалённый пользователь'}" : ( self.users.any? ? 'в процессе' : 'новая' )
  end

  def self.accessible user
    return self.all if user.is_admin
    user.tasks
  end
end
