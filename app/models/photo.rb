class Photo < ActiveRecord::Base
  attr_accessible :picture, :office_id


  has_attached_file :picture, styles: {
    big: "600x600>",
    profile: "400x400>",
    thumbnail: "64x64>",
    search: "312x208"
  }

  belongs_to(:office,
  class_name: "Office",
  foreign_key: :office_id,
  primary_key: :id
  )


end
