class MessagesController < ApplicationController
  include ApplicationHelper

  def new
  end

  def create
    @message = Message.new(params[:message])
    @message.deal_id = params[:deal_id]
    @message.sender_id = current_user.id
    @message.receiver_id = other_party_deal(@message.deal)
    if @message.save
      redirect_to edit_deal_url(@message.deal)
    else
      flash[:errors] = "Message must be between 2 and 400 characters."
      redirect_to edit_deal_url(params[:deal_id])
    end

  end

end
