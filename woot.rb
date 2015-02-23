require 'nokogiri'
require 'open-uri'
require 'net/http'

url = 'http://woot.com'
crap_not_found = true
percent_remaining_old = ''
while crap_not_found do
    html = open(url)

    doc = Nokogiri::HTML(html)
    item = doc.css('.fn').first.text.downcase
    match = /crap/ =~ item
    percent_remaining = doc.css('.percent-remaining').first.text
    if percent_remaining_old != percent_remaining
        print "\n#{item} - #{percent_remaining} (#{Time.now})"
        percent_remaining_old = percent_remaining
    end
    crap_not_found = false unless match.nil?
end
link =  doc.css('a.wantone')[0]['href']
`open http://woot.com#{link}`
