require 'watir'

class ScrapperService
  def initialize(url)
    @url = url
  end

  def scrape_and_save
    browser = Watir::Browser.new :chrome
    browser.goto(@url)

    browser.wait_until(timeout: 30) do
      browser.div(class: /sBVJqn/).exist? &&
      browser.h1(class: /_6EBuvT/).exist?
    end

    title = browser.h1(class: '_6EBuvT').span(class: 'mEh187').text rescue ""
    description = browser.h1(class: '_6EBuvT').span(class: 'VU-ZEz').text rescue ""
    discounted_price = browser.div(class: 'Nx9bqj CxhGGd').text rescue ""
    normal_price = browser.div(class: 'yRaY8j A6+E6v').text rescue ""
    discount = browser.div(class: 'UkUFwK WW8yVX dB67CR').text rescue ""
    raitings_average = browser.div(class: 'XQDdHH _1Quie7').text.to_f rescue 0.0
    raitings_reviews = browser.div(class: "_5OesEi HDvrBb VWRXZO").span(class: "Wphh3N").text rescue ""
    size_tag = browser.a(class: "CDDksN zmLe5G dpZEpc").text rescue ""

    details = extract_details(browser)
    size_description = details[:size_description]
    gender = details[:gender]
    purpose = details[:purpose]
    material = details[:material]
    features = details[:features]
    color = details[:color]
    model_product_name = details[:model_product_name]
    product_type = details[:product_type]

    image_links = browser.ul(class: 'ZqtVYK').lis.map do |li|
      li.img(class: '_0DkuPH').src rescue nil
    end.compact

    Product.create!(
      title: title,
      description: description,
      size_tag: size_tag,
      size_description: size_description,
      discounted_price: discounted_price,
      normal_price: normal_price,
      discount: discount,
      raitings_reviews: raitings_reviews,
      raitings_average: raitings_average,
      gender: gender,
      purpose: purpose,
      material: material,
      features: features,
      color: color,
      model_product_name: model_product_name,
      product_type: product_type,
      image_links: image_links
    )
    
    browser.close
    puts "Producto guardado exitosamente."
  rescue => e
    puts "Error al procesar: #{e.message}"
    browser.close
  end
  
  private

  def extract_details(browser)
    parent_container = browser.div(class: 'row IbygeN')
    raise "Contenedor padre no encontrado" unless parent_container.exists?

    expand_icon = browser.div(class: 'col col-1-12 cWwIYq')
    if expand_icon.exists?
      expand_icon.click
      sleep 10
      browser.wait_until(timeout: 10) { browser.div(class: 'sBVJqn _8vsVX1').exists? }
    end

    details_container = browser.div(class: 'sBVJqn _8vsVX1')
    raise "Contenedor de detalles no encontrado" unless details_container.exists?

    rows = details_container.divs(class: 'row')
    
    {
      size_description: rows[0]&.div(class: 'col col-9-12 -gXFvC')&.text&.strip || "",
      gender: rows[1]&.div(class: 'col col-9-12 -gXFvC')&.text&.strip || "",
      purpose: rows[2]&.div(class: 'col col-9-12 -gXFvC')&.text&.strip || "",
      material: rows[3]&.div(class: 'col col-9-12 -gXFvC')&.text&.strip || "",
      features: rows[4]&.div(class: 'col col-9-12 -gXFvC')&.text&.strip || "",
      color: rows[5]&.div(class: 'col col-9-12 -gXFvC')&.text&.strip || "",
      model_product_name: rows[6]&.div(class: 'col col-9-12 -gXFvC')&.text&.strip || "",
      product_type: rows[7]&.div(class: 'col col-9-12 -gXFvC')&.text&.strip || "",
    }
  end

end


