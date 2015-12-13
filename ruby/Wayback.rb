# query Wayback API
#

require 'json'
require 'time'
require 'net/http'

TestSites = ["news.orf.at", "nbcnews.com"]

class Wayback
  UrlAvailabiltyAPI = URI("http://archive.org/wayback/available")
  TimeStampFormat = "%Y%m%d%H%M%S"

  def initialize
  end

  def self.snapshots(url, time)
    uri = UrlAvailabiltyAPI
    uri.query = URI.encode_www_form(:url => url, :timestamp => time.strftime(TimeStampFormat))
    result = Net::HTTP.get(uri)
    JSON.parse(result)
  end

end

if $0 == __FILE__
  now = Time.now
  past = Time.new(now.year - 1, now.month, now.day, 21)
  TestSites.each do |url|
    result = Wayback.snapshots( url, past)
    puts url
    puts result.inspect
    puts
  end
end

