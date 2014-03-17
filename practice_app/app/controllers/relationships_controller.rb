class RelationshipsController < ApplicationController
  def create
    @relationship = current_user.relationships.build(:relation_id => params[:relation_id])
    if @relationship.save
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
    flash[:notice] = "Successfully removed relationship."
    redirect_to current_user
  end
end