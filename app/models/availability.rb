class Availability < ActiveRecord::Base
  attr_accessible :end_date, :office_id, :start_date

  validate :end_cannot_preceed_start, on: :save
  validate :end_cannot_preceed_start, on: :update

  belongs_to(:office,
  class_name: "Office",
  foreign_key: :office_id,
  primary_key: :id
  )


  def end_cannot_preceed_start
    errors.add(:base, "End date cannot come before start.") if (end_date < start_date)
  end

end
