class ProductsController < ApplicationController
	before_action :authenticate_user!, only: [:create,:edit,:update,:destroy]
	def new
		@product=Product.new
	end 
	def create

      @product=Product.new(products_params)
       if @product.save
         respond_to do |format|
       	 format.html{redirect_to @product,notice:'Product was added successfully'}
       	 format.json { render :show, status: :created, location: @product }
        end
      else
        flash[:error]=@product.errors.full_messages[0]
        render 'new'
      end
	end
	def index
      @products=Product.all
	end
	def show
		@product=Product.find(params[:id])
	end
	def edit
		@product=Product.find(params[:id])
	end
	def update
         @product=Product.find(params[:id])
         if @product.update(products_params)
          respond_to do |format|
         	format.html{redirect_to @product, notice:'Product was successfully updated'}
         	format.json { render :show, status: :ok, location: @user }
         end
      else
        respond_to do |format|
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
	end

	def destroy
        @product=Product.find(params[:id])
         @product.destroy
          respond_to do |format|
            format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
            format.json { head :no_content }
          end
	end
private 
	
	      def products_params
         # binding.pry
           #params.require(:product).permit(:name ,:description,:price,:image)
	      	#@value=params.fetch(:product).permit(:name, :description, :price, :image => )

           # @value=params.require(:product).permit(:name,:description,:price,params[:image])
          @value = params.require(:product).permit(:name,:description,:price,:image).tap do |whitelisted|
           whitelisted[:image] = params[:product][:image]
            #binding.pry
	          end
    end
end