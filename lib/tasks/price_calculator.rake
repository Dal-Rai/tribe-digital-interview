namespace :services do
  desc "Calculate bundle price from files"
  task :calc_price_txt, :environment do |t, args|
    prices_txt = File.read("data/prices.json")

  end

  task :seed_file, [:file, :status] => :environment do |t, args|
    service = Services::ServiceSeeder.new(args[:file], args[:status])
    service.load
  end

  task :calc_price_txt, [:file] => :environment do |t, args|
    Dir["#{args[:folder]}/*"].each do |file|
      puts "Seeding file #{file}"
      service = Services::ServiceSeeder.new(file)
      service.load
    end
  end

  task seed_price_list: :environment do
    PriceList.transaction do
      Dir[File.join(Rails.root, 'public', 'price_lists', '*')].each do |file_path|
        puts "Seeding #{file_path}"
        service = Services::PriceSeeder.new(file_path: file_path, params: {})
        service.load
      end
    end
  end
end
