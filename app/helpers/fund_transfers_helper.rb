module FundTransfersHelper
  def dd_mm_yy(date, format='dd-mm-yyyy')
    case format
    when 'dd-mm-yyyy'
      date.strftime('%d-%m-%Y')
    end
    
  end
end
