class Elected < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :assignments
  has_many :committees, through: :assignments
  validates :biography, presence: true
  validates :biography, uniqueness: true
  validates :bio_text, presence: true
end