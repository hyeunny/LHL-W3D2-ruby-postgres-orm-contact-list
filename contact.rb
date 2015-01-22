require './database'
class Contact < ActiveRecord::Base
  validates :firstname, :lastname, :email, :phone, presence: true
end
