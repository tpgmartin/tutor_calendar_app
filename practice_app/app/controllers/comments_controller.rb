class CommentsController < ApplicationController
  before_filter :load_commentable
  
  def index
    @comments = @commentable.comments 
  end

  def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(params[:comment])
    if @comment.save
      redirect_to @commentable, notice: "Comment created."
    else
      render :new
    end
  end

  private

  def load_commentable
    params.each do |name, value|
      return @commentable = $1.classify.constantize.find(value) if name =~ /(.+)_id$/
    end
  end

end