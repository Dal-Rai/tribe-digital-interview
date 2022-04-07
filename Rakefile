require 'json'
require 'pry'

# task :default => [:run]
#
# desc "Load bundle and prices"
# task "run" do
#   # $LOAD_PATH.unshift(File.dirname(__FILE__), "lib")
#   binding.pry
#   list = PostParser.price_list
#
#
#   # load the data files into strings for you
#   prices_json = File.read("data/prices.json")
#   orders_json = File.read("data/orders.json")
#   payments_json = File.read("data/payments.json")
#
#   # call the app, passing the data as strings containing JSON
#   result_json = CoffeeApp.call(prices_json, orders_json, payments_json)
#
#   # turn the JSON back into a Ruby structure
#   user_balances = JSON.load(result_json)
#
#
# end

namespace :services do
  desc "Calculate bundle price"
  $LOAD_PATH.unshift(File.dirname(__FILE__), "lib")
  require 'post_parser'
  task :calc_bundle_price, [:items] => :environment do |t, args|


    # pretty print the output
    puts "Total:"
    puts sprintf("%-10s%-11s%-11s%-11s", "user", "orders", "payments", "balance")
    puts sprintf("--------")
    user_balances.each do |user_balance|
      puts sprintf("%-10s$%-10.2f$%-10.2f$%-10.2f", user_balance["user"], user_balance["order_total"], user_balance["payment_total"], user_balance["balance"])
    end
  end
end



