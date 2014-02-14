class User < ActiveRecord::Base
validates :first_name, presence: true
validates :last_name, presence: true
validates :email, presence: true
validates :email, uniqueness: true
self.has_secure_password()
has_and_belongs_to_many :electeds
end