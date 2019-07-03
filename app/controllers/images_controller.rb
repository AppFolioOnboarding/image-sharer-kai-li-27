class ImagesController < ApplicationController
  def index; end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)
    if @image.valid?
      @image.save
      redirect_to @image
    else
      render :new, status: :unprocessable_entity
    end
  end
  private

  def image_params
    params.require(:image).permit(:url)
  end
end
