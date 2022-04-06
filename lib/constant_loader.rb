require 'yml'

class Lib::ConstantLoader
  class << self
    def load_all(file_path)
      YAML.load_file(file_path)
    end

    def load(file_name, section)
      file = YAML.load_file(file_path)
      file ? file[section] : nil
    end
  end
end
