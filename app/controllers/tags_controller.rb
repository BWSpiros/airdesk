class TagsController < ApplicationController
  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(params[:tag])
    if @tag.save
      redirect_to root_url
    end
  end

end
