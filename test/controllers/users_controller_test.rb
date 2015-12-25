require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "должен запрещать доступ к списку юзеров если админ не залогинился" do
    get :index
    assert_response :forbidden
  end
end
