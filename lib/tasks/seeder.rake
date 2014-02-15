namespace :seeder do
  desc "TODO"
  task committee: :environment do
    committees = HTTParty.get("https://congress.api.sunlightfoundation.com/committees?per_page=all&subcommittee=false&apikey=530645aaf9954433ba8dfce43742916a")["results"]
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
      assignments = HTTParty.get("https://congress.api.sunlightfoundation.com//committees?member_ids=#{elected.biography}&subcommittee=false&apikey=530645aaf9954433ba8dfce43742916a")["results"]
      assignments.each do |committee|
        assignment = committees.find_by(committee_id: committee["committee_id"])
        elected.committees << assignment
      end
    end
  end
end

