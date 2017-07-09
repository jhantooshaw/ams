class Contact < ApplicationRecord
  belongs_to :user
  has_many :addresses, as: :addressable, dependent: :destroy
  #has_many :fund_transfers,  dependent: :destroy
  
  default_scope { order('name asc') }
  self.per_page = 10
end
