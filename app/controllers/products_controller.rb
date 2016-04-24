class ProductsController < ApplicationController
	before_action :authenticate_user!, only: [:create,:edit,:update,:destroy,:index]
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
  def import
    #Call is made to import method of the Product model sending file format
    #check for file type,if  other than csv or excel dont allow
    if validate_format(params[:file])
       @imported=Product.import(params[:file])
       msg=@imported[1]
       if @imported.include?true
         redirect_to root_url,notice: msg
        else
          redirect_to root_url,alert: msg
       end
    else 
       redirect_to root_url,alert:"Wrong file type!Please upload in .csv ,.xls and .xlxs"
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
      def validate_format(file_ext)
        format_file=file_ext.original_filename.split(".").to_set
        allowed_type=%w[csv xls xlxs].to_set
        val=format_file.intersect?allowed_type
        return val
      end
end