class EndorsementsController < ApplicationController
  def create
    @endorsement = Endorsement.new(params[:endorsement])
    @endorsement.endorser_id = current_user.id
    if @endorsement.save
      return redirect_to referer,
        notice: "Successfully endorsed #{@endorsement.endorsee.name}."
    else
      return redirect_to referer,
        alert: "You cannot endorse #{@endorsement.endorsee.name}. You can neither endorse yourself nor endorse others multiple times."
    end
  end
end
