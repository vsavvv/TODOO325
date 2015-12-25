require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "запрещать доступ к списку юзеров если админ не залогинился" do
    get :index
    assert_response :forbidden
  end
  test "возможность залогиниться с учетными данными по умолчанию" do
    post :authenticate, user: { name: "admin", password: "admin" }
    assert_equal "Вход выполнен успешно", flash[:notice]
  end
end
