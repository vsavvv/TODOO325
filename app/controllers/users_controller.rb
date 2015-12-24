class UsersController < ApplicationController
  before_action :get_user_params, only: [:create]

  def index
    @users = User.all
  end

  def edit
  end

  def update
  end

  def new
    @user = User.new
  end

  def create
    User.create @user_params
    redirect_to :action => :index
  end

  def destroy
  end

  private

  def get_user_params
    @user_params = params[:user].permit(:name, :password)
  end
end
