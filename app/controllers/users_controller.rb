class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]
  before_action :find_user, only: [:show, :update, :destroy]
  def index
    @users=User.all
    render json: @users
  end
  def show
    render json: @users, status: 200
  end
  def create
    @user=User.new(user_params)
    if @user.save
      render json: @user ,status: 201
    else
      render json: {error: @user.errors.full_messages},status: 503
    end
  end
  def update
    unless @user.update(user_params)
      render json: {error: @user.errors.full_messages},status: 503
    end
  end
  def destroy
    @user.destroy
  end
  def user_params
    params.permit(:name, :user_name, :email, :password)
  end
  def find_user
    @user=User.find(params[:id])
  end
end
