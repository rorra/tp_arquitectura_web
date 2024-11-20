module OrdersHelper
  def order_status_color(status)
    case status
    when 'pending'
      'warning'
    when 'paid'
      'info'
    when 'shipped'
      'success'
    when 'cancelled'
      'danger'
    else
      'secondary'
    end
  end
end
