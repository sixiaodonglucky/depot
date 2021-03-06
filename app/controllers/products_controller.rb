class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    puts "index 0000000000000  index "+notice.to_s
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    #@product = Product.new(product_params)
    breakpoint
    @product = Product.new
    title = params[:product][:title]
    description = params[:product][:description]
    image = params[:product][:image_url]
    img_data = ""
    name = ""
    if image.present?
        img_data = image.read
        name = image.original_filename
        time = Time.now.strftime("%Y%m%d%H%M%S")
        new_name_begin = time
        new_name_end = File.extname(name)
        new_name = new_name_begin+new_name_end
        @product.image_url = new_name
        File.open("#{Rails.root}/app/assets/images/"+new_name, "wb") { |file| 
        file.write(img_data)
     }
    end  
    price = params[:product][:price]
    #content_size = image.size
    @product.title = title
    @product.description = description
    @product.price = price
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: t("depot.successfully") }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
   product = Hash.new
   price = params[:product][:price]
   title = params[:product][:title]
   description = params[:product][:description]
   image = params[:product][:image_url]
   img_data = ""
   if image.present?
      image = params[:product][:image_url]
      img_data = image.read
      name = image.original_filename
      time = Time.now.strftime("%Y%m%d%H%M%S")
      new_name_begin = time
      new_name_end = File.extname(name)
      new_name = new_name_begin+new_name_end
      product[:image_url] = new_name
      File.open("#{Rails.root}/app/assets/images/"+new_name, "wb") { |file| 
      file.write(img_data)
     }
   end
   product[:title] = title
   product[:description] = description
   product[:price] = price
   
   puts "===========================: "+product.to_s
    respond_to do |format|
      if @product.update(product)
        puts "===========================:11111111112222 "
        format.html { redirect_to @product, notice: t("depot.updated") }
        format.json { render :show, status: :ok, location: @product }
      else
        puts "===========================:1111111111 "
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  # def destroy
  #   @product.transaction do
  #     @product.destroy
  #       respond_to do |format|
  #       format.html { redirect_to products_url, notice: t("depot.destroyed")  }
  #       format.json { head :no_content }
  #   end
  #   end
    
  # end
  def destroy
    puts "8888888888888------------: #{@product.errors.empty?}" 
      @product.destroy
       respond_to do |format|
      if @product.errors.empty?
         format.html { redirect_to products_url, notice: t("depot.destroyed")  }
         format.json { head :no_content }
      else
        puts "ddddddddddddddddddddddd"
        error = ''
        @product.errors.each { |msg,val| error = val.to_s }
         format.html { redirect_to products_url,notice: error  }
         format.json { render json: @product.errors, status: :unprocessable_entity }
      end  
        
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      puts "-------------------------"+params.to_s
      params.require(:product).permit(:title, :description, :image_url, :price)
      puts "-------------------------"+params.to_s  
    end
end
