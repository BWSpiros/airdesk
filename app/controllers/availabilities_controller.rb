class AvailabilitiesController < ApplicationController
  def destroy
    @a = Availability.find(params[:id])
    @a.destroy
    @office = @a.office_id
    redirect_to office_url(@office)
  end
end
