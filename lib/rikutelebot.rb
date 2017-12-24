require "rikutelebot/version"

module Rikutelebot

	Config = Struct.new(:token)
	class Bot
		def initialize
			@conf = Config.new nil
			yield @conf
		end

		def token
			@conf.token
		end
	end
end
