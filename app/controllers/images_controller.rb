class ImagesController < ApplicationController
  def index
    tag = params[:tag]
    @images = if tag.present?
                Image.tagged_with(tag).order(created_at: :desc)
              else
                Image.order(created_at: :desc)
              end
  end

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

  def show
    @image = Image.find(params[:id])
  end

  private

  def image_params
    params.require(:image).permit(:url, :tag_list)
  end
end
