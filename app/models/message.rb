class Message < ActiveRecord::Base
  attr_accessible :deal_id, :message_body, :receiver_id, :sender_id

  validates :message_body, presence: true
  validates :message_body, length: {minimum: 2, maximum: 400}

  belongs_to(:deal,
  class_name: "Deal",
  foreign_key: :deal_id,
  primary_key: :id)

  belongs_to(:sender,
  class_name: "User",
  foreign_key: :sender_id,
  primary_key: :id)

  belongs_to(:receiver,
  class_name: "User",
  foreign_key: :receiver_id,
  primary_key: :id)



  def sending_party
    return "owner" if self.sender_id == self.deal.owner.id
    return "renter"
  end



end
