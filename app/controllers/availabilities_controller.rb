class AvailabilitiesController < ApplicationController
  before_filter :has_access, only: [:edit, :destroy, :update, :create]

  def destroy
    @a = Availability.find(params[:id])
    @a.destroy
    @office = @a.office_id
    redirect_to office_url(@office)
  end

  private

  def has_access
    redirect_to root_url if Office.find(params[:id]).owner_id != current_user.id
  end

end
