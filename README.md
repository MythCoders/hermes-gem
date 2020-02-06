# Hermes - Gem

## Getting Started

**Set Variables**

Rails credentials
```ruby
hermes[:api_key]
hermes[:api_secret]
```

Environment
* HERMES_API_KEY
* HERMES_API_SECRET
* HERMES_API_URL (optional)

**Register the Mailbox**
```ruby
# config/initializers/hermes.rb

ActionMailer::Base.add_delivery_method :hermes, Hermes::Mailbox, environment: 'dev'
```

**Configure ActionMailer to use Hermes**
```ruby
config.action_mailer.delivery_method = :hermes
```
