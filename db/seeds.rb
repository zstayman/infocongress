# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'open-uri'

Elected.delete_all
legislators = HTTParty.get("https://congress.api.sunlightfoundation.com/legislators?in_office=true&per_page=all&apikey=#{SUNLIGHT_API}")
# binding.pry
counter = 0
while counter < 100
    legislators = legislators["results"][0..537]
    legislators.each do |elected|
      Elected.create({
        house: elected["chamber"],
        first_name: elected["first_name"],
        last_name: elected["last_name"],
        gender: elected["gender"],
        biography: elected["bioguide_id"],
        nickname: elected["nickname"],
        party: elected["party"],
        district: elected["district"].to_i,
        senate_class: elected["senate_class"].to_i,
        phone_number: elected["phone"],
        birthdate: Date.parse(elected["birthday"]),
        website: elected["website"],
        state: elected["state"],
        bio_text: Nokogiri::HTML(open("http://bioguide.congress.gov/scripts/biodisplay.pl?index=#{elected["bioguide_id"]}")).xpath("//p").first.to_s.split("</font>").last.split("</p>").first.gsub("\r","").gsub("\n","")
        })
  end
  counter += 1
end