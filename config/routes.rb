Rails.application.routes.draw do
  # Get a product  
  get 'api/v1/product/:id', to: 'api/v1/products#show' 
  
  # Get all products
  get 'api/v1/products', to: 'api/v1/products#index'

  # Purchases
  get 'api/v1/products/purchase', to: 'api/v1/products#purchase'

  # Show the items in the cart
  get 'api/v1/cart', to: 'api/v1/cart#show'
  
  # Checkout current cart items 
  get 'api/v1/cart/checkout', to: 'api/v1/cart#checkout'
  
  # Clear cart contents
  get 'api/v1/cart/clear', to: 'api/v1/cart#clear'

  if Rails.env.development?
   get '404', :to => 'application#page_not_found'
  end
end
