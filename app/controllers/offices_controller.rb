class OfficesController < ApplicationController
  def index
    @offices = Office.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @offices }
    end
  end

  def show
    @office = Office.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @office }
    end
  end

  def new
    @office = Office.new

    respond_to do |format|
      format.html
      format.json { render json: @office }
    end
  end

  def edit
    @office = Office.find(params[:id])
  end

  def create
    @office = Office.new(params[:office])
    @office.owner_id = current_user.id

    respond_to do |format|
      if @office.save
        format.html { redirect_to @office, notice: 'Office was successfully created.' }
        format.json { render json: @office, status: :created, location: @office }
      else
        format.html { render action: "new" }
        format.json { render json: @office.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @office = Office.find(params[:id])

    respond_to do |format|
      if @office.update_attributes(params[:office])
        format.html { redirect_to @office, notice: 'Office was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @office.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @office = Office.find(params[:id])
    @office.destroy

    respond_to do |format|
      format.html { redirect_to offices_url }
      format.json { head :no_content }
    end
  end
end
