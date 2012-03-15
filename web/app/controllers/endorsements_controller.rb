class EndorsementsController < ApplicationController
  def create
    @endorsement = Endorsement.new(params[:endorsement])
    @endorsement.endorser_id = current_user.id
    if @endorsement.save
      redirect_to @endorsement.endorsee, :notice => "Successfully endorsed #{@endorsement.endorsee.name}"
    else
      flash.now.alert = "Could not endorse #{@endorsement.endorsee.name}"
      render :template => 'users/show'
    end
  end
end
