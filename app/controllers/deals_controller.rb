class DealsController < ApplicationController

  def index
    @deals = current_user.deals
  end

  def show
    @deal = Deal.find(params[:id])
  end

  def new
    # Not needed, should only derive from listings.
  end

  def create
    @deal = Deal.new(params[:deal])
    @deal.office_id = params[:office_id]
    @office = Office.find(params[:office_id])

    @deal.renter_id = current_user.id
    @deal.owner_id = @office.owner_id
    @deal.price = @office.price
    @deal.owner_approval = false
    @deal.renter_approval = false
    availability = @office.availabilities.sort_by{|o| o.start_date }.first || nil
    @deal.start_date = availability.start_date || nil
    @deal.end_date = availability.end_date || nil

    if @deal.save
      redirect_to edit_deal_url(@deal.id)
    else
      flash[:errors] = @deal.errors.full_messages
      render :new
    end
  end

  def edit
    @deal = Deal.find(params[:id])
    @office = Office.find(@deal.office_id)
  end

  def update
    @deal = Deal.find(params[:id])
    if @deal.owner_id == current_user.id
      @deal.owner_approval = false unless params[:deal][:owner_approval]
    else
      @deal.renter_approval = false unless params[:deal][:renter_approval]
    end
    @deal.update_attributes(params[:deal])
    @deal.save
    redirect_to deals_url
  end

  def destroy
  end


end
