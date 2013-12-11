class FavoritesController < ApplicationController

  def index
    @offices = (current_user).favorite_offices
  end


  def create
    @office = Office.find(params[:office_id])
    @fav = Favorite.new
    @fav.office_id = params[:office_id]
    @fav.user_id = current_user.id
    if @fav.save
      redirect_to @office, method: :get
    else
      flash[:errors] = @office.errors.full_messages
      render @office
    end
  end


end
