module OrdersHelper
  def render_next_order_status order
    if order.initiate?
      return "Confirm order"
    elsif order.processed?
      return "Ship order"
    elsif order.shipped?
      return "Deliver order"
    end
  end
end
