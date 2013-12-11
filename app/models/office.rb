class Office < ActiveRecord::Base
  attr_accessible :addr1, :addr2, :arrangement, :available, :city, :description, :occupancy, :owner_id, :price, :size, :title, :zip

  belongs_to(:owner,
  class_name: "User",
  foreign_key: :owner_id,
  primary_key: :id
  )

  has_many(:favoritings,
  class_name: "Favorite",
  foreign_key: :office_id,
  primary_key: :id
  )

end
