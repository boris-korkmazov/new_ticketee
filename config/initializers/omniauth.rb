Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, '1c0cdb372583b207a54c', 'e4aef33258f93fdcce01dc5dcc5a4392a73e1750', scope: "user:email,user:follow"
end