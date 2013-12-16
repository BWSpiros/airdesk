module DealsHelper

  def other_party_deal(deal)
    # fail
    return deal.owner_id if deal.owner_id == current_user.id
    return deal.renter_id
  end

end
