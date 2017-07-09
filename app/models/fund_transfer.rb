class FundTransfer < ApplicationRecord
  belongs_to  :user
  #belongs_to  :contact
  default_scope { order('transaction_date desc') }
  
  self.per_page = 10
  
  AssetType = [
    ['CREDIT', 'cr'],
    ['DEBIT', 'dr']
  ]
  
  #before_create :assign_transaction_number
  
  def assign_transaction_number
    self.transaction_number = self.class.get_transaction_number
    self.transaction_date = Date.today
  end
  
  def self.get_transaction_number
    ft_no = SecureRandom.hex(5)       
    while where(transaction_number: ft_no).present?
      ft_no = SecureRandom.hex(5)
    end
    ft_no
  end
  
  def ist_time_format
    transaction_date.strftime('%a %d %b %Y')
  end
  
  def credit_amount
    asset_type == 'cr' ? sprintf('%.2f', amount) : sprintf('%.2f', 0)
  end
  
  def debit_amount
    asset_type == 'dr' ? sprintf('%.2f', amount) : sprintf('%.2f', 0)
  end
  
  def transfer_to
    contact_id.blank? ? to_other : contact.name 
  end
  
  def contact
    Contact.find(contact_id)
  end

  def self.add_decimal_prefix(amount, num_of_zeros=2)
    sprintf("%.#{num_of_zeros}f", amount)
  end
end
