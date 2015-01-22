require 'pry' # incase you want to use binding.pry
require 'active_record'
# require_relative 'contact'


# Output messages from AR to STDOUT
ActiveRecord::Base.logger = Logger.new(STDOUT)

puts "Establishing connection to database ..."
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  encoding: 'unicode',
  pool: 5,
  database: 'djkd4gr8k3p9g',
  username: 'dtcrqprnunmpyp',
  password: 'pW9826Q2DNn1qwRAHFXKhqSuAP',
  host: 'ec2-184-73-165-193.compute-1.amazonaws.com',
  port: 5432,
  min_messages: 'error'
)

puts "Done."