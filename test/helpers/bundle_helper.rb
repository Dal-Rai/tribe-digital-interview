require ''

def data
  @data ||= YAML.load_file(File.join(Rails.root, 'config', 'bundle_price.yml'))
end