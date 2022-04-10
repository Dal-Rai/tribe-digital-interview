require_relative 'config/application'
Rails.application.load_tasks

namespace :services do
  desc "Calculate bundle price"
  $LOAD_PATH.unshift(File.dirname(__FILE__), "lib")
  require 'post_service'
  task :calc_bundle_price, [:order] => :environment do |t, args|
    PostService.new(args[:order]).print_result
  end
end
