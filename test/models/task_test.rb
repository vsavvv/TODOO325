require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test "Не должны сохранять задачу без необходимых данных" do
    task = Task.new
    assert_not task.save
  end
end
