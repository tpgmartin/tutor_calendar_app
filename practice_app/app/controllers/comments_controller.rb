class CommentsController < ApplicationController
  load_and_authorize_resource
  before_filter :load_commentable

  def index
    @comments = @commentable.comments 
  end

  def show
  end

  def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(params[:comment])
    if @comment.save
      @comment.create_activity :create, owner: current_user
      redirect_to @commentable, notice: "Comment created."
    else
      render :new
    end
  end

  private

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  # def load_commentable
  #   params.each do |name, value|
  #     return @commentable = $1.classify.constantize.find(value) if name =~ /(.+)_id$/
  #   end
  # end

end