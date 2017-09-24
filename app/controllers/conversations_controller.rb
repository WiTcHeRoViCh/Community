class ConversationsController < ApplicationController
	before_action :current_conversation, only: :show

	def index
		@conversations = current_user.conversations.map { |conversation| conversation.as_json.merge({sender: conversation.sender.profile.as_json, recipient: conversation.recipient.profile.as_json, last_message: conversation.reports.last.as_json, sender_unread_mess: conversation.reports.where(read: false, user_id: conversation.sender_id).count.as_json, recipient_unread_mess: conversation.reports.where(read: false, user_id: conversation.recipient_id).count.as_json }) } 
		@conversation = @conversations.each{|conversation| conversation[:last_message][:sender] = Conversation.find(conversation['id']).last_message.sender.profile.as_json }
	end

	def show
		@reports = Report.where(conversation_id: @conversation.id).map { |report| report.as_json.merge({ sender: report.sender.profile.as_json }) }
		@conversation = @conversation.as_json.merge({reports: @reports.as_json})
	end

	def new
	end

	def create
		user_id = params[:report][:user_id]
		recipient_id = params[:report][:recipient_id]

		sender = User.find(user_id)
		recipient = User.find(recipient_id)

		if Conversation.between(user_id, recipient_id).present?
			@conversation = Conversation.between(user_id, recipient_id).first
		else
			@conversation = Conversation.create!(conversation_params)
			sender.conversations.push @conversation
			recipient.conversations.push @conversation
		end

		@conversation.reports.where(user_id: recipient_id).update_all(read: true)
		@conversation = @conversation.reports.new(report_params)

		if @conversation.save!
			redirect_to user_profile_path(recipient, recipient)
		else

			redirect_to user_profile_path(recipient, recipient)
		end

	end

	def destroy
		
	end

	private

	def report_params
		params.require(:report).permit(:body, :user_id)
	end

	def conversation_params
		params.require(:report).permit(:sender_id, :recipient_id)
	end

	def current_conversation
		@conversation = Conversation.find(params[:id])
	end
end