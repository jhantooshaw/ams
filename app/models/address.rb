class Address < ApplicationRecord
   belongs_to :addressable, polymorphic: true
   
  def full_address
    [address, city, state, country, pin].join(', ')
  end
end
