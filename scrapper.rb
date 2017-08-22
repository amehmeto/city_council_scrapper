require 'rubygems'
require 'nokogiri'
require 'open-uri'
PAGE_URL = "http://annuaire-des-mairies.com/95/vaureal.html" 

#"http://ruby.bastardsbook.com/files/hello-webpage.html"

def get_the_email_of_a_townhall_from_its_webpage(city)

	url = "http://annuaire-des-mairies.com/95/" + city.gsub(' ', '-').downcase + ".html"

	page = Nokogiri::HTML(open(url))

	content = page.css("table tr td table tr td table tr td table tr td.style27 p.Style22")

	return content[5].text

end

def get_all_the_urls_of_val_doise_townhalls(dpt)

page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/"+dpt+".html"))

content = page.css("a.lientxt")

return content

end

cities = get_all_the_urls_of_val_doise_townhalls("val-d-oise")

resultat = Hash.new

cities.each { |e|
	resultat[e.text] = get_the_email_of_a_townhall_from_its_webpage(e.text)
}

puts resultat




