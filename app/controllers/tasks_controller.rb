class TasksController < ApplicationController
  include ApplicationHelper
  before_filter :check_if_admin, only: [:users, :join_user, :dock, :undock]

  def index
    @tasks = accessible_tasks
  end

  def new
    @user = User.find(params[:user_id]) if params[:user_id]
    @task = Task.new
  end

  def create
    task = Task.create task_params
    task.users = User.where(id: params[:task][:user_ids])
    redirect_to :action => :index
  end

  def edit
    @task = accessible_tasks.find(params[:id])
  end

  def update
    accessible_tasks.find(params[:id]).update task_params
    redirect_to :action => :index
  end

  def destroy
    accessible_tasks.find(params[:id]).destroy
    redirect_to :action => :index
  end

  def users
    @task = Task.find(params[:id])
    @users = @task.users
    render template: 'users/index'
  end

  def join_user
    @task = Task.find params[:id]
    @users = User.all.select { |user| not @task.users.include? user }
  end

  def dock
    task = Task.find(params[:id])
    task.users << User.find(params[:user_id])
    redirect_to :back
  end

  def undock
    task = Task.find(params[:id])
    task.users = task.users.where.not id: params[:user_id]
    redirect_to :back
  end

  def complete
    accessible_tasks.find(params[:id]).update completed: true, fulfilled: session[:authenticated]
    redirect_to :back
  end

  private

  def task_params
    params.require(:task).permit(:description, :completed)
  end

  def accessible_tasks
    Task.accessible(User.find(session[:authenticated]))
  end
end
