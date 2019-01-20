class Api::V1::ProductsController < ApplicationController
    # GET /products
    def index
        byebug
        if params[:instock] == "true"
            @products = Product.where("inventory_count > 0 ")
        else
            @products = Product.all
        end
        
        render json: @products
    end
    
    # GET /products/1
    def show
        @product = Product.find(params[:id])
        
        if params[:purchase]
            if params[:purchase] == "true" && @product.inventory_count > 0
                @product.inventory_count -= 1
                @product.save
                output = @product
            else
                output = {'error' => 'product out of strock'}.to_json
            end
        else
            output = @product
        end

        render json: output
    end
    
    # POST /products
    def create
        @product = product.new(product_params)
        if @product.save
            render json: @product, status: :created, location:        api_v1_product_url(@product)
        else
        render json: @product.errors, status: :unprocessable_entity
        end
    end
   
    # PATCH/PUT /products/1
    def update
        if @product.update(product_params)
            render json: @product
        else
            render json: @product.errors, status: :unprocessable_entity
        end
    end
    
    # DELETE /products/1
    def destroy
        @product.destroy
    end
    
    private
    
    # Use callbacks to share common setup or constraints between actions.
    def set_product
        @product = product.find(params[:id])
    end
    
    # Only allow a trusted parameter “white list” through.
    def product_params
        params.require(:product).permit(:title, :content, :slug)
    end
end
