# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def utf8(str)
		
		Iconv.conv('utf-8//IGNORE','gbk//IGNORE',str)
	rescue
		logger.error("converr #{str}")
		'?'
	end
end
