# ========================================
#    USERS AND ACCOUNTS
# ========================================

users = []
20.times do
  hash = {
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: '111111',
    password_confirmation: '111111'
  }
  users << hash
end
User.create(users)

User.all.each do |user|
  Account.create(user_id: user.id)
end

# ========================================
#    SERVICES
# ========================================

services = []
20.times do
  hash = {
    name: Faker::App.name,
    description: Faker::Lorem.paragraph_by_chars(256, false)
  }
  services << hash
end
Service.create(services)

# ========================================
#    PRICE_RECORDS
# ========================================

Service.all.each do |service|
  service_start_date = Faker::Date.between(3.years.ago, Date.today)
  price_record_dates = (1..5).to_a.sample.times.map do
    Faker::Date.between(service_start_date, Date.today)
  end.sort.uniq

  baseprice = (5..10).to_a.sample
  price_record_data = price_record_dates.each_with_index.map do |date, idx|
    {
      effective_from: date,
      monthly_price: baseprice + idx,
      joining_fee: 0,
      service_id: service.id
    }
  end
  PriceRecord.create(price_record_data)
end

# ========================================
#    SUBSRICTIONS
# ========================================

all_service_id = Service.all.map(&:id)
Account.all.each do |account|
  service_ids = []
  (0..5).to_a.sample.times { service_ids << all_service_id.sample }

  service_ids.uniq.each do |service_id|
    service = Service.find(service_id)
    oldest_price_record = Service.find(service_id).oldest_price_record

    start_date = Faker::Date.between(oldest_price_record.effective_from, Date.today)
    end_date = if (1..100).to_a.sample >= 70
                 nil
               else
                 Faker::Date.between(start_date, Date.today)
              end

    Subscription.create(account_id: account.id, service_id: service_id, start_date: start_date, end_date: end_date)
  end
end
