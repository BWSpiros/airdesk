class Message < ActiveRecord::Base
  attr_accessible :deal_id, :message_body, :receiver_id, :sender_id

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
    return "owner" if self.sender_id == self.deal.owner
    return "renter"
  end

  def other_party
    return self.sender_id unless self.sender_id = current_user.id
    return self.receiver_id
  end

end
