class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      UserMailer.signup_confirmation(@user).deliver
      cookies[:auth_token] = @user.auth_token
      redirect_to @user, notice: "Thank you for signing up!"
    else
      render "new"
    end
  end
end
