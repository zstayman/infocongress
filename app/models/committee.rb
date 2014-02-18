class Committee < ActiveRecord::Base
  has_many :assignments
  has_many :electeds, through: :assignments
  # validates :committee_id, presence: true
  # validates :name, uniqueness: true
  # validates :subcommittee, presence: true
end