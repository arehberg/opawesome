module Opawesome
  class Engine < ::Rails::Engine
    initializer "opawesome.tracking_methods" do |app|
      ActionController::Base.send :include, Opawesome::TrackerHelper
    end

    config.generators do |g|
      g.test_framework      :rspec,        fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets false
      g.helper false
    end
  end
end
