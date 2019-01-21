class Api::V1::CartController < ApplicationController
    def show
        if session[:cart]
            products = Product.find(session[:cart])
            @sum = products.inject(0) { |sum, p| sum + p.price }
            
            output =
            {
                'total' => @sum,
                'products' => products
            }.to_json
            
            render json: output
        else
            render json: {'alert' => 'cart is empty'}.to_json
        end
    end
    
    def checkout    
        redirect_to api_v1_products_purchase_path 
    end
    
    def clear
        session[:cart] = nil
        render json: session[:cart]
    end
end
