class Favorite < ActiveRecord::Base
  attr_accessible :office_id, :user_id

  belongs_to(:user,
  class_name: "User",
  foreign_key: :user_id,
  primary_key: :id
  )

  belongs_to(:office,
  class_name: "Office",
  foreign_key: :office_id,
  primary_key: :id
  )

end
