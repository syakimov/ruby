class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    render json: User.find(params[:id])
  end

end
