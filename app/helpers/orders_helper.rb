module OrdersHelper
  def order_status_color(status)
    case status
    when 'pending'
      'warning'
    when 'confirmed'
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
