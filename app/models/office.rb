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

  has_many(:availabilities,
  class_name: "Availability",
  foreign_key: :office_id,
  primary_key: :id
  )

  has_many(:featurings,
  class_name: "Featuring",
  foreign_key: :office_id,
  primary_key: :id
  )

  has_many(:features, through: :featurings, source: :feature )

  has_many(:photos,
  class_name: "Photo",
  foreign_key: :office_id,
  primary_key: :id
  )


  def free?(start, finish)

  end


end
