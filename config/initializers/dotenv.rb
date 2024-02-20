if Rails.env.development? || Rails.env.test?
  require 'dotenv'
  Dotenv.load(".env.#{Rails.env}")
end
