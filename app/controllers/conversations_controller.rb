class ConversationsController < ApplicationController
	  before_action :authenticate_user!

  def new
  	@item = Item.find(params[:item_id])
  end
  
  
  def create
    @item = Item.find(params[:conversation][:item_id])
    recipients = User.where(id: conversation_params[:user_id])

    conversation = current_user.send_message(recipients, conversation_params[:body], conversation_params[:subject]).conversation
    flash[:success] = "Your message was successfully sent!"
    redirect_to item_path(@item.id)
  end

  def show
    @receipts = conversation.receipts_for(current_user)
    # mark conversation as read
    conversation.mark_as_read(current_user)
  end

  def reply
    current_user.reply_to_conversation(conversation, message_params[:body])
    flash[:notice] = "Your reply message was successfully sent!"
    redirect_to conversation_path(conversation)
  end

  def archive
    conversation.move_to_trash(current_user)
    redirect_to mailboxes_inbox_path
  end

  def unarchive
    conversation.untrash(current_user)
    redirect_to mailboxes_inbox_path
  end

  private

  def conversation_params
    params.require(:conversation).permit(:user_id, :item_id, :title, :subject, :body,recipients:[])
  end
  
    def message_params
    params.require(:message).permit(:body, :subject)
  end

end
