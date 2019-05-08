module ApplicationHelper
  include SessionsHelper

  def format_price(price)
    Money.new(price * 100, 'GBP').format
  end
end
