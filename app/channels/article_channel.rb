# frozen_string_literal: true
class ArticleChannel < ApplicationCable::Channel

	def subscribed
		stream_from 'article_chennal_1'
	end

	def speak(data)
		article = data['article']

		new_article = Article.new(title: article[0], photo: article[1], description: article[2], importance: article[3], user_code: article[4])

		new_article.save!
	end

	def delete(data)
		article = Article.find(data['id'])
		article.delete
	end

end
