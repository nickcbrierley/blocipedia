class CollaboratorsController < ApplicationController
  before_action :set_wiki
  
 def new
      @collaborator  = Collaborator.new
      @collaborators = Collaborator.all
      
      @wiki = Wiki.find(params[:wiki_id])
      
      @collaborating_users   = @wiki.collaborators.map { |colab| colab.user }           
      @current_collaborators = @wiki.collaborators
      
      @users_currently_not_collaborating = User.where.not(id: @collaborating_users.map {|user| user.id})
      @currently_not_collaborators = Collaborator.where.not(id: @current_collaborators.map {|colab| colab.id}) 
      
  end
  
  def index
    @users = User.all
  end

  def create
    @collaborator = @wiki.collaborators.new(user_id: params[:user_id])
    if @collaborator.save
      flash[:notice] = "You have added #{@collaborator.user.email} to participate on this wiki."
    else
      flash[:error] = "The collaborator could not be added. Try again."
    end
    redirect_to new_wiki_collaborator_path(@wiki)
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    if @collaborator.destroy
      flash[:notice] = "#{@collaborator} was removed and can no longer particiate on this wiki."
    else
      flash[:error] = "Error removing #{@collaborator}, try again."
    end
    redirect_to new_wiki_collaborator_path
  end

  private

  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end

end
