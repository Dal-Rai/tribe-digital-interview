require_relative 'config/application'
Rails.application.load_tasks

namespace :services do
  desc "Calculate bundle price"
  $LOAD_PATH.unshift(File.dirname(__FILE__), "lib")
  require 'post_service'
  task :calc_bundle_price, [:posts] => :environment do |t, args|
    PostService.new(args[:posts]).print_result
  end
end
