class EndorsementsController < ApplicationController
  def create
    @endorsement = Endorsement.new(params[:endorsement])
    @endorsement.endorser_id = current_user.id
    if @endorsement.save
      redirect_to referer, notice: "Successfully endorsed #{@endorsement.endorsee.name}."
    else
      # TODO render..
      redirect_to referer, alert: "Could not endorse #{@endorsement.endorsee.name}."
    end
  end
end
