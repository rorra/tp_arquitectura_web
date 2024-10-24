# Admin user
AdminUser.create!(email: "rorra@rorra.com.ar", name: "Rodrigo Dominguez", password: "password", password_confirmation: "password") unless AdminUser.where(email: "rorra@rorra.com.ar").exists?

# Clean old data
Product.destroy_all
Category.destroy_all

categories = {
  'Electrónica' => [
    { name: "Smartphone Samsung Galaxy S21", description: "Teléfono móvil con pantalla de 6.2 pulgadas y cámara de 64MP.", price: 800000, stock: 50, base_image: 'galaxy_s21' },
    { name: "Laptop Apple MacBook Air M1", description: "Portátil con chip M1 y 256GB de almacenamiento.", price: 1800000, stock: 30, base_image: 'macbook_air_m1' },
    { name: "Televisor Samsung 4K 55", description: "Televisor LED UHD 4K de 55 pulgadas.", price: 950000, stock: 40, base_image: 'samsung_tv_55' },
    { name: "Auriculares Bluetooth In-Ear F9-5 Negro Inalámbricos", description: "Auriculares inalámbricos con cancelación de ruido.", price: 7600, stock: 70, base_image: 'in_ear_f9-5' },
    { name: "Tablet Samsung Galaxy Tab S7", description: "Tablet de 11 pulgadas con procesador Snapdragon 865+", price: 1700000, stock: 25, base_image: 'galaxy_tab_s7' },
    { name: "Cámara Canon EOS Rebel T7", description: "Cámara DSLR con lente 18-55mm.", price: 1150000, stock: 20, base_image: 'canon_rebel_t7' },
    { name: "Smartwatch Apple Watch Series 7", description: "Reloj inteligente con pantalla Retina y seguimiento de salud.", price: 84999, stock: 40, base_image: 'apple_watch_series7' },
    { name: "Consola PlayStation 5", description: "Consola de videojuegos de última generación.", price: 299999, stock: 10, base_image: 'ps5' },
    { name: "Monitor LG UltraWide 29\"", description: "Monitor LED 29 pulgadas ultrawide.", price: 79999, stock: 35, base_image: 'lg_ultrawide_29' },
    { name: "Impresora HP DeskJet 2775", description: "Impresora multifunción con conectividad inalámbrica.", price: 14999, stock: 100, base_image: 'hp_deskjet_2775' },
    { name: "Auriculares JBL TUNE 500", description: "Auriculares con cable, sonido JBL Pure Bass.", price: 3999, stock: 80, base_image: 'jbl_tune500' },
    { name: "Parlante Bluetooth JBL GO 4", description: "Parlante portátil con resistencia al agua.", price: 95200, stock: 60, base_image: 'jbl_go4' },
    { name: "Cámara de seguridad Xiaomi Mi 360", description: "Cámara de seguridad con visión nocturna.", price: 9999, stock: 50, base_image: 'xiaomi_mi_360' },
    { name: "Drone DJI Mini 2", description: "Drone compacto con cámara 4K y transmisión HD.", price: 259999, stock: 15, base_image: 'dji_mini2' }
  ],
  'Ropa' => [
    { name: "Camiseta Nike Dri-FIT", description: "Camiseta deportiva de tejido transpirable.", price: 4999, stock: 100, base_image: 'nike_drifit' },
    { name: "Zapatillas Adidas Ultraboost", description: "Zapatillas de running de alto rendimiento.", price: 19999, stock: 60, base_image: 'adidas_ultraboost' },
    { name: "Chaqueta The North Face", description: "Chaqueta impermeable para actividades al aire libre.", price: 29999, stock: 30, base_image: 'tnf_jacket' },
    { name: "Camisa Tommy Hilfiger", description: "Camisa casual de algodón.", price: 10999, stock: 50, base_image: 'tommy_camisa' },
    { name: "Pantalón Levi's 501", description: "Jeans clásicos de corte recto.", price: 14999, stock: 40, base_image: 'levis_501' },
    { name: "Buzo Puma Essentials", description: "Buzo de algodón con capucha.", price: 7999, stock: 80, base_image: 'puma_buzo' },
    { name: "Campera Adidas Originals", description: "Campera deportiva retro.", price: 15999, stock: 40, base_image: 'adidas_campera' },
    { name: "Short Nike Running", description: "Short deportivo liviano.", price: 3999, stock: 100, base_image: 'nike_short' },
    { name: "Remera Puma Core", description: "Remera básica de algodón.", price: 2999, stock: 120, base_image: 'puma_remera' },
    { name: "Zapatillas Reebok Classic", description: "Zapatillas clásicas de cuero.", price: 12999, stock: 60, base_image: 'reebok_classic' },
    { name: "Cinturón Lacoste", description: "Cinturón casual de cuero genuino.", price: 9999, stock: 40, base_image: 'lacoste_cinturon' },
    { name: "Gorra New Era Yankees", description: "Gorra ajustable con logo de los Yankees.", price: 4999, stock: 70, base_image: 'new_era_gorra' }
  ],
  'Libros' => [
    { name: "El Quijote de la Mancha", description: "Obra clásica de Miguel de Cervantes.", price: 2999, stock: 200, base_image: 'quijote' },
    { name: "Cien años de soledad", description: "Novela de Gabriel García Márquez.", price: 3499, stock: 150, base_image: 'cien_anos_soledad' },
    { name: "1984 - George Orwell", description: "Novela distópica de George Orwell.", price: 2999, stock: 180, base_image: '1984_orwell' },
    { name: "Rayuela - Julio Cortázar", description: "Obra icónica de la literatura argentina.", price: 3999, stock: 100, base_image: 'rayuela' },
    { name: "El Aleph - Jorge Luis Borges", description: "Colección de cuentos por Borges.", price: 2599, stock: 200, base_image: 'aleph' },
    { name: "Ficciones - Jorge Luis Borges", description: "Otra colección notable de cuentos por Borges.", price: 2899, stock: 190, base_image: 'ficciones' },
    { name: "El Principito - Antoine de Saint-Exupéry", description: "Fábula francesa clásica.", price: 1999, stock: 300, base_image: 'principito' },
    { name: "Harry Potter y la piedra filosofal", description: "Primera entrega de la serie Harry Potter.", price: 4999, stock: 120, base_image: 'harry_potter_1' },
    { name: "Los juegos del hambre - Suzanne Collins", description: "Novela distópica juvenil.", price: 3499, stock: 140, base_image: 'juegos_hambre' },
    { name: "La sombra del viento - Carlos Ruiz Zafón", description: "Novela ambientada en la Barcelona del siglo XX.", price: 3999, stock: 130, base_image: 'sombra_viento' }
  ],
  'Hogar' => [
    { name: "Aspiradora Dyson V11", description: "Aspiradora inalámbrica de alto rendimiento.", price: 99999, stock: 10, base_image: 'dyson_v11' },
    { name: "Refrigerador LG No Frost 420L", description: "Heladera No Frost con 420 litros de capacidad.", price: 149999, stock: 20, base_image: 'lg_no_frost' },
    { name: "Microondas Samsung 28L", description: "Microondas digital con 28 litros de capacidad.", price: 19999, stock: 50, base_image: 'samsung_microondas' },
    { name: "Licuadora Philips ProBlend", description: "Licuadora de alto rendimiento.", price: 9999, stock: 40, base_image: 'philips_licuadora' },
    { name: "Aspiradora Kärcher WD3", description: "Aspiradora multiuso para seco y húmedo.", price: 14999, stock: 30, base_image: 'karcher_aspiradora' },
    { name: "Ventilador Liliana Turbo 20\"", description: "Ventilador de pie con 20 pulgadas de diámetro.", price: 7999, stock: 60, base_image: 'liliana_ventilador' },
    { name: "Cafetera Nespresso Essenza Mini", description: "Cafetera de cápsulas compacta.", price: 18999, stock: 20, base_image: 'nespresso_essenza' },
    { name: "Plancha Philips Azur", description: "Plancha a vapor de alta eficiencia.", price: 5999, stock: 50, base_image: 'philips_plancha' },
    { name: "Purificador de agua Philips", description: "Purificador con sistema de filtros.", price: 7999, stock: 100, base_image: 'philips_purificador' },
    { name: "Tostadora Oster TSSTTR", description: "Tostadora eléctrica con 7 niveles.", price: 4999, stock: 80, base_image: 'oster_tostadora' }
  ]
}

# Verify if we have images already downloaded, if not, download them
unless Dir["./db/images"].size <= 5
  require "rest-client"
  require "json"
  require "fileutils"
  require "open-uri"
  require "timeout"

  BING_API_KEY = "YOUR_BING_API_KEY_HERE" # Replace with bing api key
  # Bing rate limit: 3 requests per second
  RATE_LIMIT = 3 # Maximum requests per second
  REQUEST_DELAY = 1.0 / RATE_LIMIT # Delay between requests

  def search_images_bing(query, count = 4)
    encoded_query = URI.encode_www_form_component(query)
    url = "https://api.bing.microsoft.com/v7.0/images/search?q=#{encoded_query}&count=#{count}&imageType=Photo&size=Large"

    headers = {
      "Ocp-Apim-Subscription-Key" => BING_API_KEY,
      "Content-Type" => "application/json"
    }

    response = RestClient.get(url, headers)
    result = JSON.parse(response.body)

    image_urls = result["value"].map { |img| img["contentUrl"] }
    image_urls
  end

  def download_and_save_images(image_urls, base_name)
    image_urls.each_with_index do |url, index|
      extension = File.extname(URI.parse(url).path)
      extension = ".jpg" if extension.empty?
      extension.downcase!
      file_name = "./db/images/#{base_name}_#{index}#{extension}"

      begin
        Timeout.timeout(2) do
          File.open(file_name, 'wb') do |file|
            file.write(URI.open(url).read)
          end
        end
        puts "Saved image: #{file_name}"
      rescue => e
        puts "Error downloading image: #{e.message}"
      end
    end
  end

  categories.each do |category, products|
    products.each do |product|
      puts "Searching images for: #{product[:name]}"
      query = product[:name]
      base_image = product[:base_image]

      # Search for images using Bing API
      image_urls = search_images_bing(query)

      # Download and save the images
      if image_urls.any?
        download_and_save_images(image_urls, base_image)
      else
        puts "No images found for: #{product[:name]}"
      end

      # Add a delay to respect the rate limit of 3 requests per second
      sleep(REQUEST_DELAY)
    end
  end
end

categories.each do |category_name, products|
  category = Category.create!(name: category_name)

  products.each do |product_data|
    product = category.products.create!(
      name: product_data[:name],
      description: product_data[:description],
      price: product_data[:price],
      stock: product_data[:stock]
    )

    main_image_file = File.open(Rails.root.join("db/images/#{product_data[:base_image]}_0.jpg"))
    product.main_image.attach(io: main_image_file, filename: "#{product_data[:base_image]}_0.jpg")

    (1..4).each do |i|
      additional_image_path = Rails.root.join("db/images/#{product_data[:base_image]}_#{i}.jpg")
      if File.exist?(additional_image_path)
        additional_image_file = File.open(additional_image_path)
        product.additional_images.attach(io: additional_image_file, filename: "#{product_data[:base_image]}_#{i}.jpg")
      end
    end
  end
end

# Set 5 random products as featured
Product.all.sample(5).each do |product|
  product.update!(featured: true)
end

puts "Admin, Categories and Products created!"