module ApplicationHelper
  include SessionsHelper

  def format_price(price)
    Money.new(price * 100, 'GBP').format
  end

  def format_date(datetime)
    datetime.strftime('%d %B %Y, %A')
  end

  def title(current_page = nil)
    title = " :: #{current_page}" unless current_page.blank?
    content_for :title, title
  end
end
