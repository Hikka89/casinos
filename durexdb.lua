local internet = require("internet")
local serialization = require("serialization")
DurexDatabase = {}

function DurexDatabase:new(token)

	local obj= {}
        obj.token = token
	obj.url = "http://195.133.144.89:5000/"

	function obj:setToken(token)
		self.token = token
	end

	function obj:get(nick)
		for temp in internet.request(self.url.."users/get?name="..nick.."&token="..self.token) do      
			return tonumber(temp)
		end
	end

	function obj:getTime()
		for temp in internet.request("http://durex77.pythonanywhere.com/get/time") do      
			return tonumber(temp)
		end
	end

	function obj:pay(nick,money)
		zalupa = money-(money*2)
		for temp in internet.request(self.url.."users/give?name="..nick.."&token="..self.token.."&money="..zalupa) do
			if temp == "Poebemsya?" then 
				return true
			end
		end
	end

	function obj:give(nick,money)
		for temp in internet.request(self.url.."users/give?name="..nick.."&token="..self.token.."&money="..money) do
			--return temp == "True"
			if temp == "Poebemsya?" then 
				return true
			end
		end
	end
  
  function obj:top()
		for temp in internet.request(self.url.."top") do
			return serialization.unserialize(temp)
		end
	end
  
	setmetatable(obj, self)
	self.__index = self; return obj
end
