class Office < ActiveRecord::Base
  attr_accessible :addr1, :addr2, :arrangement, :available, :city, :state, :description, :occupancy, :owner_id, :price, :size, :title, :zip, :longitude, :latitude

  validates :title, :longitude, :price, :arrangement, :occupancy, presence: true
  validates :price, numericality: { greater_than: 0, less_than: 100000}
  validates :occupancy, numericality: { greater_than: 0, less_than: 200}

  geocoded_by :address

  reverse_geocoded_by :latitude, :longitude do |o, res|
    if res = res.first
      o.state = res.state if o.state == nil || o.state != o.state
      o.zip = res.zipcode if o.zip == nil
      o.city = res.city if o.city == nil || o.city != res.city
    end
  end

  before_validation :geocode
  before_create :reverse_geocode

  before_update :geocode

  belongs_to(:owner,
  class_name: "User",
  foreign_key: :owner_id,
  primary_key: :id
  )

  has_many(:favoritings,
  class_name: "Favorite",
  foreign_key: :office_id,
  primary_key: :id,
  dependent: :destroy
  )

  has_many(:availabilities,
  class_name: "Availability",
  foreign_key: :office_id,
  primary_key: :id,
  dependent: :destroy
  )

  has_many(:featurings,
  class_name: "Featuring",
  foreign_key: :office_id,
  primary_key: :id,
  dependent: :destroy
  )

  has_many(:features, through: :featurings, source: :feature )

  has_many(:photos,
  class_name: "Photo",
  foreign_key: :office_id,
  primary_key: :id,
  dependent: :destroy
  )

  has_many(:deals,
  class_name: "Deal",
  foreign_key: :office_id,
  primary_key: :id,
  dependent: :destroy
  )


  def address
    [self.addr1, self.city, self.state, self.zip].compact.keep_if{|e| e != ""}.join(", ")
  end
  #
  # def hard_geocode
  #   addr = address.keep_if {|el| el != ""}
  #   while addr.length > 0
  #     geoaddr = addr.join(", ")
  #     Office.geocoded_by geoaddr.to_sym
  #     status = self.geocode
  #     return status if status != nil
  #     addr = addr[1..-1]
  #   end
  #   return nil
  # end
  #
  def free?(start, finish)

  end


end
