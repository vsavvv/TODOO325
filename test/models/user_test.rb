require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "Не должны сохранять юзера без необходимых данных" do
    user = User.new
    assert_not user.save
  end
end
