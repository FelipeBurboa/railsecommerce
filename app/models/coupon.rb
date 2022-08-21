class Coupon < ApplicationRecord
  belongs_to :user, optional: true

  def usable?
    valid_on_count?
  end

  def valid_on_count?
    if kind.eql?('target')
      return (count > 0)
    end
    return true
  end

  def compute_total(total)
    if discount.eql?('percent')
      percent_value = amount /100 
      total = total - (total * percent_value) #Retorno explicito
    else
      total = total - amount
      (total < 0) ? 0 : total
    end
  end

end
