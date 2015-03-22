admin_user = User.create(email: "admin@example.com",
  name: "admin",
  password: "password",
  password_confirmation: "password",
  admin: true)

Project.create(name: "Ticketee Beta")