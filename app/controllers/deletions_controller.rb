class DeletionsController < ApplicationController
  def destroy
    @user = User.find(params[:user_id])
    @deletion = @user.deletions.find(params[:id])
    @deletion.destroy

    respond_to do |format|
      format.html { redirect_to :controller => 'home', :action => 'index' }
    end
  end
end
