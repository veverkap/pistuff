require "rubygems"
require "json"

file = File.read("state.json")

doc = JSON.load(file)

doc["modules"][0]["resources"].each do |resource|
  primary = resource[1]["primary"]["attributes"]

  id = primary["id"]
  puts "terraform import cloudflare_record.#{primary["name"]} #{primary["zone_id"]}/#{id}"
end
