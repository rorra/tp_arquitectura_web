module ApplicationHelper
  def page_title(title = nil)
    base_title = t("site.name")
    title.present? ? "#{title} - #{base_title}" : base_title
  end

  def flash_class(type)
    {
      notice: "alert-success",
      success: "alert-success",
      error: "alert-danger",
      alert: "alert-warning"
    }[type.to_sym] || "alert-info"
  end

  def current_locale_name
    t("locales.#{I18n.locale}")
  end

  def format_date(date, format = :default)
    l(date, format: format) if date
  end

  def format_currency(amount)
    number_to_currency(amount, locale: I18n.locale)
  end
end
