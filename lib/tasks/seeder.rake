namespace :seeder do
  desc "TODO"
  task committee: :environment do
    committees = HTTParty.get("https://congress.api.sunlightfoundation.com/committees?per_page=all&subcommittee=false&apikey=#{SUNLIGHT_API.to_s}")["results"]
    committees.each do |committee|
      Committee.create({
        name: committee["name"],
        chamber: committee["chamber"],
        committee_id: committee["committee_id"],
        subcommittee: committee["subcommittee"]
        })
    end
  end

  desc "TODO"
  task assignment: :environment do
    Assignment.delete_all
    committees = Committee.all
    electeds = Elected.all
    electeds.each do |elected|
      assignments = HTTParty.get("https://congress.api.sunlightfoundation.com//committees?member_ids=#{elected.biography}&subcommittee=false&apikey=#{SUNLIGHT_API.to_s}")["results"]
      assignments.each do |committee|
        assignment = committees.find_by(committee_id: committee["committee_id"])
        elected.committees << assignment
      end
    end
  end

  desc "TODO"
  task fec_id: :environment do
    Elected.all.each do |elected|
      number = HTTParty.get("http://transparencydata.org/api/1.0/entities/id_lookup.json?apikey=#{SUNLIGHT_API.to_s}&bioguide_id=#{elected.biography}")
      if number.first.nil? ? number = nil : number = number.first["id"]
        elected.fec_id = number
        elected.save
      end
    end
  end
end


