module ApplicationHelper
  def check_if_admin
    raise 'Доступ запрещён' unless User.find(session[:authenticated]).is_admin
  end

  def authenticated_user
    User.find(session[:authenticated])
  end
end
