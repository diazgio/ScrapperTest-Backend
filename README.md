# Scraper Backend

This project is a backend developed in Ruby on Rails 8 that uses the `watir` gem to perform web scraping on e-commerce pages, with an example based on the reference link from Flipkart: [https://www.flipkart.com/srpm-wayfarer-sunglasses/p/itmaf19ae5820c06](https://www.flipkart.com/srpm-wayfarer-sunglasses/p/itmaf19ae5820c06).

The backend allows:

- Extracting product data from the webpage.
- Creating a product with the extracted data and storing it in the database.
- Displaying all created products through an endpoint.
- Displaying details of a single product.

## Technologies Used

- **Ruby on Rails 8**: Main framework for building the backend.
- **Watir**: To perform web scraping of product data.
- **json-serializer**: To format JSON responses in a structured way.
- **CORS**: To allow requests from different origins.

## Installation

1. Clone this repository:

   ```bash
   git clone <repository-url>
   cd scraper-backend
   ```

2. Install the dependencies:

   ```bash
   bundle install
   ```

3. Set up the database:

   ```bash
   rails db:create db:migrate
   ```

4. Start the server:
   ```bash
   rails server
   ```

## Endpoints

### Create a Product

**POST** `/products`

This endpoint scrapes the product from a specific URL, extracts the required information, and saves it to the database.

#### Request Body

```json
{
  "url": "https://www.flipkart.com/srpm-wayfarer-sunglasses/p/itmaf19ae5820c06"
}
```

#### Example Response

```json
{
  "data": {
    "id": "8",
    "type": "product",
    "attributes": {
      "id": 8,
      "title": "SRPM ",
      "description": "UV Protection Wayfarer Sunglasses (50)  (For Men & Women, Clear, Black, Brown)",
      "size_tag": "Medium",
      "discounted_price": "",
      "normal_price": "₹1,299",
      "discount": "87% off",
      "raitings_reviews": "64,935 ratings and 5,210 reviews",
      "raitings_average": 3.7,
      "image_links": [
        "https://rukminim2.flixcart.com/image/128/128/xif0q/sunglass/9/q/m/medium-sun-2019-s1-srpm-original-imah4v7ysvwhrfnw.jpeg?q=70&crop=false",
        "https://rukminim2.flixcart.com/image/128/128/xif0q/sunglass/9/q/m/medium-sun-2019-s1-srpm-original-imah4v7ysvwhrfnw.jpeg?q=70&crop=false",
        "https://rukminim2.flixcart.com/image/128/128/xif0q/sunglass/u/a/u/medium-sun-2019-s1-srpm-original-imah4v7ykfggvmrn.jpeg?q=70&crop=false",
        "https://rukminim2.flixcart.com/image/128/128/xif0q/sunglass/t/a/g/medium-sun-2019-s1-srpm-original-imah4v7ynzhs39ah.jpeg?q=70&crop=false",
        "https://rukminim2.flixcart.com/image/128/128/xif0q/sunglass/4/a/t/medium-sun-2019-s1-srpm-original-imah4v7yrfjpfasa.jpeg?q=70&crop=false",
        "https://rukminim2.flixcart.com/image/128/128/xif0q/sunglass/l/x/e/medium-sun-2019-s1-srpm-original-imah4v7yhcwbbr6h.jpeg?q=70&crop=false",
        "https://rukminim2.flixcart.com/image/128/128/xif0q/sunglass/q/2/0/medium-sun-2019-s1-srpm-original-imah4v7ywfdz5dn9.jpeg?q=70&crop=false"
      ],
      "clean_product_details": [
        {
          "product_key": "Size",
          "product_value": "This product is sold as Medium by the Brand"
        },
        {
          "product_key": "Ideal For",
          "product_value": "Men & Women"
        },
        {
          "product_key": "Purpose",
          "product_value": "Driving, Running, Style, Biking, Eye Protection"
        },
        {
          "product_key": "Lens Color and Material",
          "product_value": "Clear, Black, Brown, CR 39"
        },
        {
          "product_key": "Features",
          "product_value": "UV Protection"
        },
        {
          "product_key": "Frame Color",
          "product_value": "Black, Brown"
        },
        {
          "product_key": "Model Name",
          "product_value": "Wayfarer"
        },
        {
          "product_key": "Type",
          "product_value": "Wayfarer"
        },
        {
          "product_key": "Style Code",
          "product_value": "SUN_2019-S1"
        },
        {
          "product_key": "Frame",
          "product_value": "Full-frame"
        },
        {
          "product_key": "Face Type",
          "product_value": "Heart, Long, Square, Round, Diamond, Oval"
        },
        {
          "product_key": "Frame Material",
          "product_value": "Plastic"
        },
        {
          "product_key": "Brand Color",
          "product_value": "Black, Brown, Clear"
        },
        {
          "product_key": "Frame Color for Refiner",
          "product_value": "Black, Brown"
        },
        {
          "product_key": "Net Quantity",
          "product_value": "3"
        },
        {
          "product_key": "Pack of",
          "product_value": "3"
        },
        {
          "product_key": "Sales Package",
          "product_value": "3 Subglass, 1 Box"
        },
        {
          "product_key": "Secondary Type",
          "product_value": "Wayfarer"
        },
        {
          "product_key": "HD Vision",
          "product_value": "No"
        },
        {
          "product_key": "UV Protection",
          "product_value": "100"
        },
        {
          "product_key": "Case Type",
          "product_value": "Pouch"
        }
      ]
    }
  }
}
```

### List All Products

**GET** `/products`

This endpoint returns all the products stored in the database.

#### Example Response

```json
[
  {
    "id": 1,
    "title": "SRPM ",
    "discounted_price": "",
    "normal_price": "₹1,299",
    "raitings_reviews": "64,810 ratings and 5,203 reviews",
    "raitings_average": 3.7
  },
  {
    "id": 2,
    "title": "SRPM ",
    "discounted_price": "",
    "normal_price": "₹1,299",
    "raitings_reviews": "64,810 ratings and 5,203 reviews",
    "raitings_average": 3.7
  }
]
```

### Show a Product

**GET** `/products/:id`

This endpoint returns the details of a specific product by its ID.

#### Example Response

```json
{
  "data": {
    "id": "8",
    "type": "product",
    "attributes": {
      "id": 8,
      "title": "SRPM ",
      "description": "UV Protection Wayfarer Sunglasses (50)  (For Men & Women, Clear, Black, Brown)",
      "size_tag": "Medium",
      "discounted_price": "",
      "normal_price": "₹1,299",
      "discount": "87% off",
      "raitings_reviews": "64,935 ratings and 5,210 reviews",
      "raitings_average": 3.7,
      "image_links": [
        "https://rukminim2.flixcart.com/image/128/128/xif0q/sunglass/9/q/m/medium-sun-2019-s1-srpm-original-imah4v7ysvwhrfnw.jpeg?q=70&crop=false",
        "https://rukminim2.flixcart.com/image/128/128/xif0q/sunglass/9/q/m/medium-sun-2019-s1-srpm-original-imah4v7ysvwhrfnw.jpeg?q=70&crop=false"
      ],
      "clean_product_details": [
        {
          "product_key": "Size",
          "product_value": "This product is sold as Medium by the Brand"
        },
        {
          "product_key": "Ideal For",
          "product_value": "Men & Women"
        }
      ]
    }
  }
}
```

## Additional Configuration

- **CORS**: Enabled to allow requests from any origin. You can adjust this configuration in `config/initializers/cors.rb` if you need specific restrictions.
- **Watir**: Ensure you have a compatible browser, such as Chrome, and its corresponding driver (e.g., `chromedriver`).

## Notes

1. This project is a functional example. For a production environment, consider handling exceptions, validating inputs, and securing database connections.
2. Scraping may be subject to the terms of service of the target website. Ensure you comply with the site's usage policies.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
