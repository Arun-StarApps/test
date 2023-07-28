# frozen_string_literal: true
module LetscaleRuby

  class Initializer
    def self.run
      unless LetscaleRuby.find_by(queue: 'sendLetscaleLog')
        LetscaleRuby.start_log
      end
    end
  end

  class Railtie < Rails::Railtie
      config.after_initialize do
        # Don't start the reporter in a Rails console.
        # NOTE: This is untested because we initialize the Rails test app in test_helper.rb,
        # so the reporter has already started before any of the tests run. You can manually
        # test this by running `DYNO=web.1 rails c` in sample-apps/rails-sample.
        puts "check========== #{ ENV["DYNO"]}"
        puts "================ inside railtie================"  if ENV["DYNO"]&.start_with?("worker")
        # Initializer.run
      end
  end
  require('letscale_ruby/models/letscale_ruby')

end
