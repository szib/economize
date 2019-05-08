module ApplicationHelper
  include SessionsHelper

  def format_price(price)
    Money.new(price * 100, 'GBP').format
  end

  def format_date(datetime)
    datetime.strftime('%d %B %Y, %A')
  end
end
