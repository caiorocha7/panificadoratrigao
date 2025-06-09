require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'support/factory_bot'
require 'pundit/rspec'

# Adicionamos o require aqui para garantir que a gem seja carregada
require 'factory_bot_rails'
require 'database_cleaner/active_record'

# Carrega todos os arquivos em spec/support
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  config.fixture_paths = [
    Rails.root.join('spec/fixtures')
  ]
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  
  # *** A CONFIGURAÇÃO CORRETA ESTÁ AQUI ***
  # Inclui os métodos do FactoryBot (ex: create, build) nos seus testes
  config.include FactoryBot::Syntax::Methods
  
  # Inclui nosso helper de API para testes de requisição
  config.include ApiHelpers, type: :request

  # Configuração do Shoulda Matchers
  Shoulda::Matchers.configure do |shoulda_config|
    shoulda_config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end

  # Configuração do Database Cleaner
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end