# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
require 'devise' # ✅ Add Devise so helpers work properly

# Add additional requires below this line. Rails is not loaded until this point!
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

# Ensure test database schema matches development
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  # ✅ Include Devise helpers
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include Warden::Test::Helpers  # for login helpers in feature specs
  config.after(type: :feature) { Warden.test_reset! }

  # Fixture path
  config.fixture_paths = [Rails.root.join('spec/fixtures')]

  # Use transactions for tests (recommended for ActiveRecord)
  config.use_transactional_fixtures = true

  # Infer spec type (controller, model, request, etc.) automatically by file location
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces
  config.filter_rails_from_backtrace!

  # Optional: clearer backtrace filtering
  config.filter_gems_from_backtrace("rack", "railties", "rspec-rails")

  # Optional: automatically clean DB between tests
  # Uncomment if using database_cleaner gem
  # config.before(:suite) do
  #   DatabaseCleaner.strategy = :transaction
  #   DatabaseCleaner.clean_with(:truncation)
  # end
  #
  # config.around(:each) do |example|
  #   DatabaseCleaner.cleaning do
  #     example.run
  #   end
  # end
end
