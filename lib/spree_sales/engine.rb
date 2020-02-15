module SpreeSales
  class Engine < Rails::Engine
    require "spree/core"
    
    isolate_namespace Spree
    engine_name "spree_sales"

    config.autoload_paths += %W[#{config.root}/lib]

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer "spree.register.sale_configuration", before: :load_config_initializers do |_app|
      SpreeSales::Config = Spree::SalesConfiguration.new
      SpreeSales::Config[:sale_calculators] << Spree::Calculator::AmountSalePriceCalculator.to_s
      SpreeSales::Config[:sale_calculators] << Spree::Calculator::PercentOffSalePriceCalculator.to_s
      
      ActiveSupport.on_load :action_controller do
        ActionController::Base.send :helper, SpreeSales::BaseHelper
      end
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
