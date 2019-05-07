require 'faker'
users = []
users << {
  first_name: 'Ivan',
  last_name: 'Szebenszki',
  email: 'ivan.szebenszki@flatironschool.com',
  password: '111111',
  password_confirmation: '111111'
}

users << {
  first_name: 'Susan',
  last_name: 'Jones',
  email: 'susanjones789@gmail.com',
  password: 'abc3829',
  password_confirmation: 'abc3829'
}

users << {
  first_name: 'Anna',
  last_name: 'Jones',
  email: 'annajones234@gmail.com',
  password: 'abc3829',
  password_confirmation: 'abc3829'
}

users << {
  first_name: 'Tan',
  last_name: 'Smith',
  email: 'tansmith34@gmail.com',
  password: 'def3829',
  password_confirmation: 'def3829'
}


User.create(users)

account_1 = Account.create(user_id: 1)
account_2 = Account.create(user_id: 2)
account_3 = Account.create(user_id: 3)
account_4 = Account.create(user_id: 4)


netflix = Service.create(name: 'Netflix', description: 'Extremely popular video entertainment platform....')
spotify = Service.create(name: 'Spotify', description: 'Popular music streaming service with...')
amazon_prime = Service.create(name: 'Amazon Prime', description: 'One-day shipment and delivery service...')

price_record_1 = PriceRecord.create(effective_from: DateTime.new(2017, 3, 1), monthly_price: 20.10, joining_fee: 0, service_id: 1)
price_record_2 = PriceRecord.create(effective_from: DateTime.new(2018, 12, 10), monthly_price: 10.20, joining_fee: 7, service_id: 2)
price_record_3 = PriceRecord.create(effective_from: DateTime.new(2016, 10, 10), monthly_price: 15.50, joining_fee: 2.50, service_id: 3)
price_record_4 = PriceRecord.create(effective_from: DateTime.new(2018, 9, 5), monthly_price: 7.99, joining_fee: 7, service_id: 2)
price_record_5 = PriceRecord.create(effective_from: DateTime.new(2019, 2, 2), monthly_price: 15.99, joining_fee: 2.50, service_id: 3)

subscription_1 = Subscription.create(start_date: DateTime.new(2017, 3, 1), end_date: DateTime.new(2018, 3, 1), account_id: 2, service_id: 1)
subscription_2 = Subscription.create(start_date: DateTime.new(2018, 4, 5), end_date: DateTime.new(2018, 9, 12), account_id: 2, service_id: 2)
subscription_3 = Subscription.create(start_date: DateTime.new(2018, 12, 8), end_date: DateTime.new(2019, 5, 2), account_id: 2, service_id: 3)
subscription_4 = Subscription.create(start_date: DateTime.new(2017, 12, 23), end_date: DateTime.new(2018, 12, 21),  account_id: 1, service_id: 1)
subscription_5 = Subscription.create(start_date: DateTime.new(2018, 8, 15), end_date: DateTime.new(2018, 11, 22),  account_id: 3, service_id: 3)
subscription_6 = Subscription.create(start_date: DateTime.new(2018, 12, 8), end_date: DateTime.new(2018, 12, 14),  account_id: 4, service_id: 2)
