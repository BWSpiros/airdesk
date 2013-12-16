class OfficesController < ApplicationController

  skip_before_filter :check_logged_in, only: [:index,:show]

  before_filter :has_access, only: [:edit, :destroy, :update]


  def index
    @offices = Office.last(10)
    @features = Feature.all
    @current_features = params[:search_params] == nil ? [] : params[:search_params][:features]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @offices }
    end
  end

  def find

    @features = Feature.all
    @current_features = params[:search_params][:features] == nil ? [] : params[:search_params][:features][1..-1].map{|f| f.to_i}
    # fail
    search_params = []

    # To seriously refactor!

    if params[:search_params]
      if params[:search_params][:city] != ""
        city = params[:search_params][:city]
        search_params << ["city LIKE '%#{city}%'"]
      end
      if params[:search_params][:price] != ""
        price = params[:search_params][:price]
        search_params << ["price < #{price}"]
      end
    end

    search_params = search_params.join(" AND ")
    # epic fail
    # Need to refactor the keep_if below to be a proper SQL query

    @offices = Office.where(search_params).order("created_at DESC")
    @offices.keep_if{|o| (o.features.map{|f| f.id}. & @current_features) == @current_features }
    @current_features.map!{|f| f.to_s}
    # fail
    respond_to do |format|
      format.html { render "offices#index" => @offices}
      format.json { render json: @offices }
    end
  end

  def show
    @office = Office.find(params[:id])
    @availabilities = @office.availabilities
    @features = @office.features
    @photos = @office.photos[0]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @office }
    end
  end

  def new
    @office = Office.new
    @availabilities = [Availability.new]
    @features = Feature.all
    @current_features = []
    respond_to do |format|
      format.html
      format.json { render json: @office }
    end
  end

  def edit
    @office = Office.find(params[:id])
    @availabilities = @office.availabilities + [Availability.new]
    @features = Feature.all
    @current_features = @office.features.map{|f| f.id}
  end

  def create
    begin
      ActiveRecord::Base.transaction do
        # fail
        @office = Office.new(params[:office])
        @office.owner_id = current_user.id
        @availabilities = params[:availabilities].map{|_, av_params| Availability.new(av_params)}
        @feats = (params[:features])[1..-1].map{|f| Feature.find(f)} # First value always blank?
        @office.save
        if params[:photos]
          @office.photos = [Photo.create({picture: params[:photos][:picture], office_id: @office.id})]
        end
        @office.features = @feats

        current_feats = @office.featurings
        # @feats.each {|f| }

        @availabilities.keep_if{|a| !a.start_date.nil? && !a.end_date.nil? }
        @availabilities.each {|av| av.office = @office; av.save}

        raise "invalid" unless @office.valid? && @availabilities.all? {|a| a.valid?}

      end
    # rescue
    #   flash[:errors] = @office.errors.full_messages + @availabilities.map(&:errors).flatten.full_messages
    #   render :new
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

        @feats = (params[:features])[1..-1].map{|f| Feature.find(f)} # First value always blank?
        @office.features = @feats
        photo = [Photo.create({picture: params[:photos][:picture], office_id: @office.id})] if params[:photos]
        @office.photos = photo if photo


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
    # rescue
    #   flash[:errors] = @office.errors.full_messages + @availabilities.map(&:errors).flatten
    #   render :new
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
