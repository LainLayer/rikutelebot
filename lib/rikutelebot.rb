require "rikutelebot/version"
require 'open-uri'
require 'json'

module Rikutelebot

	Config = Struct.new(:token) do
		def getupdatesurl
			"https://api.telegram.org/bot#{token}/getUpdates"
		end
	end
	
	User = Struct.new(:first_name, :last_name, :id, :username)

	Chat = Struct.new(:id, :title, :username)

	Message = Struct.new(:from, :chat, :text) do
		def format
			"<#{from.first_name}@#{chat.username}>: #{text}"
		end
	end

	class Bot
		def initialize
			@conf = Config.new nil
			yield @conf
		end

		def run
			updates = []
			j = JSON.parse  open(@conf.getupdatesurl).read()
			for update in j['result']
				fn = update['message']['from']['first_name']
				ln = update['message']['from']['last_name']
				id = update['message']['from']['id']
				un = update['message']['from']['username']

				usr = User.new(fn, ln, id, un)

				id = update['message']['chat']['id']
				title = update['message']['chat']['title']
				un = update['message']['chat']['username'] || 'Private chat'

				chat = Chat.new(id, title, un)

				yield Message.new(usr, chat, update['message']['text']) unless update['message']['text'].nil?
			end
		end

	end

end
