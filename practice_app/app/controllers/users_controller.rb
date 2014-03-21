class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.relation_ids << current_user.id, owner_type: "User")#.page(params[:page])
    @commentable = @user
    @comments = @commentable.comments
    @comment = Comment.new  
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      UserMailer.signup_confirmation(@user).deliver
      @user.create_activity :create, owner: current_user
      cookies[:auth_token] = @user.auth_token
      redirect_to @user, notice: "Thank you for signing up!"
    else
      render "new"
    end
  end
end
