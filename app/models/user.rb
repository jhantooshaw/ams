class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable
       
  has_many :contacts,  dependent: :destroy
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :fund_transfers,  dependent: :destroy
  
  def monthly_cr_dr(start_date=Date.today)
    start_month = start_date.at_beginning_of_month
    end_month = start_date.end_of_month
    fts = fund_transfers.select('sum(amount) as total_amount, asset_type').where(transaction_date: start_month..end_month).group('asset_type')
    cr = fts.select{|ft| ft.asset_type == 'cr'}.first
    dr = fts.select{|ft| ft.asset_type == 'dr'}.first
    return cr,dr
  end
end
