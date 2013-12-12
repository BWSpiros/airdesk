class OfficesController < ApplicationController

  skip_before_filter :check_logged_in, only: [:index,:show]

  before_filter :has_access, only: [:edit, :destroy, :update, :create]


  def index
    @offices = Office.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @offices }
    end
  end

  def show
    @office = Office.find(params[:id])
    @availabilities = @office.availabilities

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @office }
    end
  end

  def new
    @office = Office.new
    @availabilities = [Availability.new]
    respond_to do |format|
      format.html
      format.json { render json: @office }
    end
  end

  def edit
    @office = Office.find(params[:id])
    @availabilities = @office.availabilities + [Availability.new]
  end

  def create

    begin
      ActiveRecord::Base.transaction do
        @office = Office.new(params[:office])
        @office.owner_id = current_user.id
        @availabilities = params[:availabilities].map{|_, av_params| Availability.new(av_params)}
        @office.save
        @availabilities.keep_if{|a| !a.start_date.nil? && !a.end_date.nil? }

        @availabilities.each {|av| av.office = @office; av.save}

        raise "invalid" unless @office.valid? && @availabilities.all? {|a| a.valid?}

      end
    rescue
      flash[:errors] = @office.errors.full_messages + @availabilities.map(&:errors).flatten.full_messages
      render :new
    else
      redirect_to root_url
    end

    # Maybe revive for backbone
    # respond_to do |format|
    #   if @office.save
    #     format.html { redirect_to @office, notice: 'Office was successfully created.' }
    #     format.json { render json: @office, status: :created, location: @office }
    #   else
    #     format.html { render action: "new" }
    #     format.json { render json: @office.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def update
    begin
      ActiveRecord::Base.transaction do
        @office = Office.find(params[:id])
        @office.update_attributes(params[:office])

        @availabilities = params[:availabilities].map do |_, av_params|
          if av_params[:id]
            av = Availability.find(av_params[:id])
            av_params[:id] = ""
            if av_params.all?{|x, y| y == ""}
              av.destroy
              next nil
            end
            av.update_attributes(av_params)
            av
          else
            Availability.new(av_params)
          end
        end.compact
      @availabilities.keep_if {|x| x.attributes != Availability.new.attributes }

      @availabilities.each {|av| av.office_id = params[:id]; av.save}

      raise "invalid" unless @office.valid? && @availabilities.all? {|a| a.valid?}
      end
    rescue
      flash[:errors] = @office.errors.full_messages + @availabilities.map(&:errors).flatten
      render :new
    else
      redirect_to root_url
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

  private

  def has_access
    redirect_to root_url if Office.find(params[:id]).owner_id != current_user.id
  end

end
