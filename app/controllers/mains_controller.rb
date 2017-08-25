class MainsController < ApplicationController

	def index
		@users_profile = Profile.all
	end

	private

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
  	messages.each_with_index{|e, i| 

      if e.id == message && messages[i+1] != nil
  			if messages[i].created_at.strftime("%d") != messages[i+1].created_at.strftime("%d")
  				return true
  			end
  		end

  	}
  	return false
  end

  def articles
    usr_code = []
    User.all.each{|user| usr_code.push(user.code) if user.profile.hide_news == false }

    @articles = Article.where(user_code: usr_code).sort.reverse
  end

  def projects
    @projects = Project.all.includes(:user).reverse
  end


  helper_method :messages, :room, :message, :hr_line, :articles, :projects
end
