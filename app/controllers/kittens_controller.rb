class KittensController < ApplicationController
  before_action :set_kitten, only: %i[show edit update destroy]

  def index
    @kittens = Kitten.all
  end

  def show; end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)
    if @kitten.save
      flash[:notice] = "You added a kitten! Great job!"
      redirect_to @kitten
    else
      flash.now[:alert] = "Something went wrong! Maybe you gave it negative cuteness?"
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @kitten.update(kitten_params)
      flash[:notice] = "Kitten updated successfully!"
      redirect_to @kitten
    else
      flash.now[:alert] = "Update failed. Are you sure this kitten is soft enough?"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @kitten.destroy
    flash[:notice] = "Kitten deleted. Monster!"
    redirect_to kittens_path
  end

  private

  def set_kitten
    @kitten = Kitten.find(params[:id])
  end

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end
end
