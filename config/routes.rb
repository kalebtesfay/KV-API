Rails.application.routes.draw do
  # Get a product  
  get 'api/v1/product/:id', to: 'api/v1/products#show' 
  
  # Get all products
  get 'api/v1/products', to: 'api/v1/products#index'
  
  # Show the items in the cart
  get 'api/v1/cart', to: 'api/v1/cart#show'
  
  # Checkout current cart items 
  get 'api/v1/cart/checkout', to: 'api/v1/cart#checkout'
  
  # Clear cart contents
  get 'api/v1/cart/clear', to: 'api/v1/cart#clear'
  
  # Add to cart 
  get 'api/v1/cart/add', to: 'api/v1/cart#add'
  
end
