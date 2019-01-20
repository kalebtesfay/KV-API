Rails.application.routes.draw do
  # Get Specific product  
  # /product/:id/?purchase=true => purchase one of a specific stock 
  get 'api/v1/product/:id', to: 'api/v1/products#show' 
  
  # Get all products // query string parameter
  # /products/?instock=true => show only products that are in stock
  get 'api/v1/products', to: 'api/v1/products#index'
end
