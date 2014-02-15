class Assignment < ActiveRecord::Base
  belongs_to :elected
  belongs_to :committee
end