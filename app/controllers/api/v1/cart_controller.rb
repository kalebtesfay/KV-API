class Api::V1::CartController < ApplicationController
    def show
        
        if session[:cart]
            render json: Product.find(session[:cart])
        else
            render json: {'alert' => 'cart is empty'}.to_json
        end
    end
    
    def checkout
        if session[:cart]
            product_ids = session[:cart]
            output = ProductsController.purchase(product_ids)
        end
        
        render json: output
    end
    
    def clear
        session[:cart] = nil
        render json: session[:cart]
    end
    
    def add
        if session[:cart]
            session[:cart].push(params[:id])
            
        else
            session[:cart] = Array.new
        end
        
        render json: session[:cart]
    end
end
