require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "rails/test_unit/railtie"

Bundler.require(:default, :test, DEVISE_ORM) if defined?(Bundler)

begin
  require "#{DEVISE_ORM}/railtie"
rescue LoadError
end

require "devise"
require "devise_invitable"

module RailsApp
  class Application < Rails::Application
    # Add additional load paths for your own custom dirs
    config.load_paths.reject!{ |p| p =~ /\/app\/(\w+)$/ && !%w(controllers helpers views).include?($1) }
    config.load_paths += [ "#{config.root}/app/#{DEVISE_ORM}" ]
    
    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters << :password
    
    config.action_mailer.default_url_options = { :host => "localhost:3000" }
  end
end