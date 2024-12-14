require 'watir'
require 'webdrivers'

class ScrapperService
  def initialize(url)
    @url = url
  end

  def scrape_and_save
    Selenium::WebDriver::Chrome::Service.driver_path = '/usr/local/bin/chromedriver'

    browser = Watir::Browser.new(
    :chrome,
    options: {
      binary: '/usr/bin/chromium-browser',
      args: %w[headless disable-gpu no-sandbox disable-dev-shm-usage]
    }
  )

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

    image_links = browser.ul(class: 'ZqtVYK').lis.map do |li|
      li.img(class: '_0DkuPH').src rescue nil
    end.compact
    
    browser.close

    product_data ={
      title: title,
      description: description,
      size_tag: size_tag,
      normal_price: normal_price,
      discount: discount,
      raitings_reviews: raitings_reviews,
      raitings_average: raitings_average,
      product_details: details.map(&:to_json),
      image_links: image_links
    }
    puts product_data
    product_data
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
      sleep 5
      
      read_more = browser.button(class: 'QqFHMw n4gy8q')
      read_more.click if read_more.exists?
      sleep 5
      browser.wait_until(timeout: 10) { browser.div(class: 'sBVJqn').exists? }
    end
  
    details_container = browser.div(class: 'sBVJqn')
    raise "Contenedor de detalles no encontrado" unless details_container.exists?
  
    rows = details_container.divs(class: 'row')
  
    product_details = rows.map do |row|
      key_element = row.div(class: 'col col-3-12 _9NUIO9')
      value_element = row.div(class: 'col col-9-12 -gXFvC')
  
      if key_element.exists? && value_element.exists?
        {
          product_key: key_element.text.strip,
          product_value: value_element.text.strip
        }
      else
        nil
      end
    end.compact
  
    product_details
  end
end


