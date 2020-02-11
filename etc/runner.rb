require 'net/http'
require 'uri'
require 'xmlhasher'
require 'pp'

uri = URI.parse("http://windows:32400/library/sections/15/all?X-Plex-Token=mzrZoLF54m-mREMPe7_J")

response = Net::HTTP.get_response(uri)
XmlHasher.parse(response.body)[:MediaContainer][:Video].each do |video|
  year = video[:year]
  title = video[:title]
  file = video[:Media][:Part][:file].gsub("X:\\Kids\\Movies\\", "")
  oldfile = "/share/USBDisk2/Kids/Movies/#{file}"
  newfolder = "/share/USBDisk2/Kids/Movies/#{title} (#{year})"
  # pp video
  # /Volumes/USBDisk2/Kids/Movies
  # puts year
  # puts title
  # puts file
  puts "echo \"Making #{newfolder}\""
  puts "mkdir \"#{newfolder}\""
  puts "echo \"Copying file over\""
  puts "mv \"#{oldfile}\" \"#{newfolder}/#{file}\""
end
