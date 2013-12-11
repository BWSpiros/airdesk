class Office < ActiveRecord::Base
  attr_accessible :addr1, :addr2, :arrangement, :available, :city, :description, :occupancy, :owner_id, :price, :size, :title, :zip
end
