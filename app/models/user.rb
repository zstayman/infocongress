class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true

  has_secure_password

  has_and_belongs_to_many :electeds

  def follow_local_electeds

    locals = HTTParty.get("https://congress.api.sunlightfoundation.com/legislators/locate?zip=#{self.zip}&apikey=#{ENV['SUNLIGHT_API']}")["results"]

    locals.each do |local|
      elected = Elected.find_by(biography: local["bioguide_id"])
      self.electeds << elected
    end

  end

end