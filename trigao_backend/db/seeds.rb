require 'json'

# Mapeamento dos IDs de seção do JSON para nomes e descrições de Categoria.
# Esta é nossa camada de tradução de dados legados para o novo modelo.
CATEGORY_MAPPING = {
  "1" => { name: "Padaria", description: "Pães, fermentos e itens de panificação." },
  "2" => { name: "Confeitaria", description: "Bolos, doces, tortas e sobremesas." },
  "3" => { name: "Sucos e Vitaminas", description: "Bebidas naturais preparadas na hora." },
  "4" => { name: "Guloseimas", description: "Chocolates, balas, doces industrializados." },
  "5" => { name: "Bebidas", description: "Refrigerantes, sucos, águas e bebidas." },
  "6" => { name: "Taxas e Embalagens", description: "Itens de serviço e entrega." },
  "21" => { name: "Promoções e Inativos", description: "Itens promocionais ou fora de linha." },
  "22" => { name: "Salgados", description: "Salgados fritos e assados." },
  "23" => { name: "Encomendas", description: "Itens para festas e encomendas." },
  "24" => { name: "Biscoitos e Petas", description: "Biscoitos artesanais e petas." },
  "25" => { name: "Frios e Laticínios", description: "Queijos, iogurtes, manteigas e frios." },
  "26" => { name: "Sorvetes e Congelados", description: "Sorvetes, picolés e polpas de fruta." },
  "27" => { name: "Mercearia", description: "Itens de uso geral, higiene e limpeza." },
  "28" => { name: "Lanches e Refeições", description: "Pratos, lanches e buffet." }
}.freeze

puts "==> Iniciando o script de Seed..."

# Envolvemos toda a operação em uma transação para garantir a atomicidade.
ActiveRecord::Base.transaction do
  puts "\n[1/4] Limpando dados antigos de Produtos e Categorias..."
  # A ordem é importante para respeitar as chaves estrangeiras.
  Product.destroy_all
  Category.destroy_all
  puts "  - Dados antigos removidos."

  puts "\n[2/4] Criando Categorias a partir do mapeamento..."
  # Usamos um hash para acesso O(1) à categoria pelo ID do JSON.
  categories_map = {}
  CATEGORY_MAPPING.each do |id, attrs|
    category = Category.create!(attrs)
    categories_map[id] = category
    puts "  - Categoria '#{category.name}' criada."
  end

  puts "\n[3/4] Lendo JSON e populando Produtos..."
  file_path = Rails.root.join('db', 'produtos-trigao.json')
  products_json = JSON.parse(File.read(file_path))

  products_created = 0
  products_updated = 0

  products_json.each do |category_id, products_array|
    category = categories_map[category_id]
    unless category
      puts "  - AVISO: Categoria com ID '#{category_id}' não encontrada no mapeamento. Pulando produtos."
      next
    end

    products_array.each do |product_data|
      # Lógica de negócio: define o status baseado no nome do produto.
      product_status = product_data['product_name'].to_s.upcase.include?('INATIVO') ? :inactive : :active
      
      # Lógica de idempotência: busca pelo código único.
      product = Product.find_or_initialize_by(code: product_data['code'])
      
      was_new_record = product.new_record?

      # Mapeamento dos campos do JSON para os atributos do modelo.
      product.update!(
        name: product_data['product_name'].strip,
        category: category,
        price: product_data['price'],
        unit: product_data['unit'],
        stock_level: product_data['quantity'] || 0, # Garante um valor padrão.
        status: product_status,
        tax_info: product_data['tax']
      )
      
      if was_new_record
        products_created += 1
      else
        products_updated += 1
      end
    end
  end
  puts "  - Processamento de produtos concluído."
  puts "    > #{products_created} produtos CRIADOS."
  puts "    > #{products_updated} produtos ATUALIZADOS."


  # --- Bloco de Criação de Usuários Adicionado ---
  puts "\n[4/4] Criando usuários de teste..."
  default_password = 'superseguro123'

  User.find_or_create_by!(email: 'master@trigao.com') do |user|
    user.password = default_password
    user.password_confirmation = default_password
    user.role = :master
    puts "  - Usuário 'master@trigao.com' criado."
  end

  User.find_or_create_by!(email: 'caixa@trigao.com') do |user|
    user.password = default_password
    user.password_confirmation = default_password
    user.role = :padrao
    puts "  - Usuário 'caixa@trigao.com' criado."
  end
  # -----------------------------------------------
end # Fim da transação

puts "\n==> Seed concluído com sucesso! <="