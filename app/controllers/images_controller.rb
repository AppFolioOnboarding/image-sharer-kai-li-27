class ImagesController < ApplicationController
  def index
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.create(image_params)
    if @image.valid?
      redirect_to @image
    else 
      render :new
    end
    
  end

  def show
    @image = Image.find(params[:id])
  end

  private 
  def image_params
    params.require(:image).permit(:url)
  end
end