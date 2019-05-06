users = []
users << {
  first_name: 'Ivan',
  last_name: 'Szebenszki',
  email: 'ivan.szebenszki@flatironschool.com',
  password: '111111',
  password_confirmation: '111111'
}

User.create(users)
