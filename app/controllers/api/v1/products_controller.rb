class Api::V1::ProductsController < ApplicationController
    def index
        byebug
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
                product_id = @product.id
                CartController.add(product_id)
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
        Product.where(params[:product_ids]).each do |p|
            if p.inventory_count > 0
                p.inventory_count -= 1
                p.save
            else 
                if !failed_ids 
                    failed_ids = Array.new
                else
                    failed_ids.push(p.id)
                end
            end
        end
        
        if failed_ids
            output = 
            {
                'error' => 'error some products failed to be purchased',
                'product_ids' => failed_ids
            }.to_json
        else
            output = {'alert' => 'product purchase succesful'}.to_json
        end
        output
    end
end
