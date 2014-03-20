class RelationshipsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @user = current_user   
  end

  def create
    @relationship = current_user.relationships.build(:relation_id => params[:relation_id])
    if @relationship.save
      @relationship.create_activity :create, owner: current_user
      flash[:notice] = "Added relation."
      redirect_to current_user
    else
      flash[:error] = "Unable to add relation."
      render :action => 'new'
    end
  end

  def destroy
    @relationship = current_user.relationships.find(params[:id])    
    @relationship.destroy
    @relationship.create_activity :destroy, owner: current_user
    flash[:notice] = "Successfully removed relationship."
    redirect_to current_user
  end
end