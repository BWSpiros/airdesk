module DealsHelper

  def other_party_deal(deal)
    return deal.owner_id unless deal.owner_id = current_user.id
    return deal.renter_id
  end

end
