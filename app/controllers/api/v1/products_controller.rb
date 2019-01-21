class Api::V1::ProductsController < ApplicationController
    def index
        if params[:instock] == "true"
            @products = Product.where("inventory_count > 0 ")
        else
            @products = Product.all
        end
        
        render json: @products
    end
    
    def show
        @product = Product.find(params[:id])
        
        if params[:addtocart]
            if params[:addtocart] == "true" && @product.inventory_count > 0
                addtocart(@product.id)
                output = @product
            else
                output = {'error' => 'product out of strock'}.to_json
            end
        else
            output = @product
        end
        render json: output
    end
    
    def purchase
        if session[:cart]
            Product.find(session[:cart]).each do |p|
                if p.inventory_count > 0
                    p.inventory_count -= 1
                    p.save
                    
                    if !@success_ids 
                        @success_ids = Array.new
                    end
                    @success_ids.push(p.id)
                else 
                    if !@failed_ids 
                        @failed_ids = Array.new
                    end
                    @failed_ids.push(p.id)
                end
            end
        end
            
        output = 
        {
            'alert' => 'purchase completed',
            'failed_product_ids' => @failed_ids,
            'successful_product_ids' => @success_ids
        }.to_json
       
        session[:cart] = nil
        render json: output
    end
    
    def addtocart(product_id)
        if ! session[:cart]
            session[:cart] = Array.new
        end

        session[:cart].push(product_id)
    end
end
