class ReviewsController < ApplicationController
  def create
    this_product = Product.find params['product_id']
    new_raiting = this_product.reviews.create({
      user_id: current_user.id,
      rating: params['rating'],
      description: params['message']
    })

    if new_raiting.id.present?
      redirect_to '/'
    else
      redirect_to :back
    end
  end

  def destroy
    Review.find(params[:id]).destroy
    redirect_to "/products/#{params['product_id']}"
  end
end
