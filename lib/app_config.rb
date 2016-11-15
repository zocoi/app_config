require 'hashie'
require 'rails'

class AppConfig
  def self.method_missing(name, *args, &block)
    if respond_to?(name) && args.empty?
      temp = Hashie::Mash.new(YAML.load(ERB.new(IO.read(config_file_path(name))).result))
      temp = temp[rails_env] if temp.has_key? rails_env
      define_singleton_method name do
        temp
      end
      return temp
    end
    super
  end

  def self.respond_to?(sym)
    return true if File.exists? config_file_path(sym)
    super
  end

  protected

  def self.config_file_path(name)
    File.expand_path(config_file_name(name), Rails.root)
  end

  def self.config_file_name(name)
    "config/#{name}.yml"
  end

  def self.rails_env
    @rails_env ||= ENV['RAILS_ENV'] || ENV['rails_env'] || :development
  end
end