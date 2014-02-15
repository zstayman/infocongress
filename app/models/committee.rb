class Committee < ActiveRecord::Base
  has_many :assignments
  has_many :electeds, through: :assignments
end