class UsersController < ApplicationController
  include ApplicationHelper
  skip_before_filter :check_if_authenticated, only: [:authenticate]
  before_filter :check_if_admin, except: [:sign_in, :authenticate, :exit]

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    User.find(params[:id]).update user_params
    redirect_to :action => :index
  end

  def new
    @task = Task.find(params[:task_id]) if params[:task_id]
    @user = User.new
  end

  def create
    user = User.create user_params
    user.tasks = Task.where(id: params[:user][:task_ids])
    redirect_to :action => :index
  end

  def destroy
    raise 'Нельзя удалять самого себя' if params[:id].to_i == session[:authenticated]
    User.find(params[:id]).destroy
    redirect_to :action => :index
  end

  def sign_in
  end

  def authenticate
    user = User.find_by user_params
    session[:authenticated] = user.id if user
    if session[:authenticated]
      flash.delete :error
      flash[:notice] = "Вход выполнен успешно"
      redirect_to controller: session[:controller_back], action: session[:action_back]
    else
      flash[:error] = 'Доступ запрещен'
      render action: :sign_in, status: :forbidden
    end
  end

  def exit
    session.delete :authenticated
    render action: :sign_in
  end

  def tasks
    @user = User.find(params[:id])
    @tasks = @user.tasks
    render template: 'tasks/index'
  end

  def join_task
    @user = User.find params[:id]
    @tasks = Task.where(completed: false).select { |task| not task.users.include? @user }
  end

  def dock
    user = User.find(params[:id])
    user.tasks << Task.find(params[:task_id])
    redirect_to :back
  end

  def undock
    user = User.find(params[:id])
    user.tasks = user.tasks.where.not id: params[:task_id]
    redirect_to :back
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :is_admin)
  end
end
