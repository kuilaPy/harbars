class Refund < ApplicationRecord
  belongs_to :order
  belongs_to :payment

  def fetch_status
    return "processed" if self.status == 'processed'
    raz_refund = Razorpay::Refund.fetch(self.raz_refund_id)
    if raz_refund.present?
      if raz_refund.status != self.status
        self.update(status: raz_refund.status)
      end
      return raz_refund.status
    else
      return nil
    end
  end
end
