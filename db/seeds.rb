# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'open-uri'

Elected.delete_all
legislators = HTTParty.get("http://congress.api.sunlightfoundation.com/legislators?in_office=true&per_page=all&apikey=#{ENV['SUNLIGHT_API']}")["results"]
# binding.pry
counter = 0
while counter < 538
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
      counter += 1
  end
end

Committee.delete_all
committees = HTTParty.get("http://congress.api.sunlightfoundation.com/committees?per_page=all&subcommittee=false&apikey=#{ENV['SUNLIGHT_API']}")["results"]
committees.each do |committee|
  Committee.create({
    name: committee["name"],
    chamber: committee["chamber"],
    committee_id: committee["committee_id"],
    subcommittee: committee["subcommittee"]
    })
end

Assignment.delete_all
committees = Committee.all
electeds = Elected.all
electeds.each do |elected|
  assignments = HTTParty.get("http://congress.api.sunlightfoundation.com//committees?member_ids=#{elected.biography}&subcommittee=false&apikey=#{ENV['SUNLIGHT_API']}")["results"]
  assignments.each do |committee|
    assignment = committees.find_by(committee_id: committee["committee_id"])
    elected.committees << assignment
end
end

Elected.all.each do |elected|
  number = HTTParty.get("http://transparencydata.org/api/1.0/entities/id_lookup.json?apikey=#{ENV['SUNLIGHT_API']}&bioguide_id=#{elected.biography}")
  if number.first.nil? ? number = nil : number = number.first["id"]
    elected.fec_id = number
    elected.save
end
end
