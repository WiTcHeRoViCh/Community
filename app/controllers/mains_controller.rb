class MainsController < ApplicationController

	def index
		@users_profile = prof
	end	

	private

	def prof
		c = []
		users = User.all.includes(:profile)

		for user in users do 
			c.push(user.profile)
		end
		return c
	end

  def room
  	"1"
  end

  def messages
  	@messages ||= Message.all.sort
  end

  def message
    @message ||= Message.new
  end

  def hr_line(message)
  	messages.each_with_index{|e, i| if e.id == message && messages[i+1] != nil

  			if messages[i].created_at.strftime("%d") != messages[i+1].created_at.strftime("%d")
  				return true
  			else
  				return false
  			end

  		end
  	}
  	return false
  end

  def articles
    @articles ||= Article.all.sort.reverse
  end


  helper_method :messages, :room, :message, :hr_line, :articles
end
