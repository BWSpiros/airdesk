class FeaturingsController < ApplicationController
  before_filter :has_access, only: [:edit, :destroy, :update, :create]

  def destroy
    @f = Featuring.find(params[:id])
    @f.destroy
    @office = @f.office_id
    redirect_to office_url(@office)
  end

  private

  def has_access
    redirect_to root_url if Office.find(Featuring.find(params[:id]).office_id).owner_id != current_user.id
  end

end
