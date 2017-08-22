require 'rubygems'
require 'nokogiri'
require 'open-uri'
PAGE_URL = "https://coinmarketcap.com/all/views/all/" 

def get_the_rate(coin)
	page = Nokogiri::HTML(open(PAGE_URL))
	selector = "#id-" + coin.gsub(" ","-").gsub(/(\.|\'|\(|\))/,"").downcase + " > td:nth-child(5) > a"
	
	#To get themissing currencies, try using "doc.xpath('//li[contains(text(), "Apple")]')" instead of css
	#Problem identified with special IDs like for bytecoin
	#id-bytecoin-bcn > td:nth-child(5) > a

	rate = page.css (selector)
	puts coin + " " + rate.text
	return rate.text
end

def get_the_coins
	page = Nokogiri::HTML(open(PAGE_URL))
	#coins = page.xpath('//div[@id="currencies-all_wrapper"]//table[@id="currencies-all"]//td//a')
	coins = page.css('td.no-wrap.currency-name > a')

	return coins
end

result = Hash.new

#puts get_the_rate("Miners' Rewar...")

get_the_coins.each{ |e|
	result[e.text] = get_the_rate(e.text)
}

puts result