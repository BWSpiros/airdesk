class Featuring < ActiveRecord::Base
  attr_accessible :feature_id, :office_id

  belongs_to(:feature,
  class_name: "Feature",
  foreign_key: :feature_id,
  primary_key: :id
  )

  belongs_to(:office,
  class_name: "Office",
  foreign_key: :office_id,
  primary_key: :id
  )

end
