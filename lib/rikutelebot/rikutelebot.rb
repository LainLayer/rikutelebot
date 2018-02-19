require "rikutelebot/version"

module Rikutelebot
	BotConfig = Struct.new(:token, :command_char)

	class Bot
		def initialize
			@conf = BotConfig.new(nil, nil)
			yield(@conf)
		end
	end
end
