Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # Use a variável de ambiente para flexibilidade entre dev, staging e prod
    origins ENV.fetch("FRONTEND_URL") 

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      # Exponha o header de autorização para o cliente conseguir lê-lo
      expose: ['Authorization'], 
      credentials: true
  end
end