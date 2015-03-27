User.all.each do |single|
  single.destroy
end

admin_user = User.create(id: 1, email: "admin@example.com",
  name: "admin",
  password: "password",
  password_confirmation: "password",
  admin: true)
Project.all.each do |single|
  single.destroy
end
Project.create(name: "Ticketee Beta")
State.all.each do |single|
  single.destroy
end
State.create(:name => "New", :background=> "#85ff00", :color=> "white")

State.create(:name => "Open", :background=> "#00CFFD", :color=> "white")

State.create(:name => "Closed", :background=> "black", :color=> "white")