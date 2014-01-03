class Deal < ActiveRecord::Base
  attr_accessible :end_date, :office_id, :owner_approval, :owner_id, :price, :renter_approval, :renter_id, :start_date

  belongs_to(:owner,
  class_name: "User",
  foreign_key: :owner_id,
  primary_key: :id
  )

  belongs_to(:renter,
  class_name: "User",
  foreign_key: :renter_id,
  primary_key: :id
  )

  belongs_to(:office,
  class_name: "Office",
  foreign_key: :office_id,
  primary_key: :id
  )

  has_many(:messages,
  class_name: "Message",
  foreign_key: :deal_id,
  primary_key: :id,
  dependent: :destroy
  )


end
