class StoreController < ApplicationController
  include CurrentCart
  before_filter :set_cart
  skip_before_filter :authorize
  def index
    if params[:set_locale]
      redirect_to store_url(locale: params[:set_locale])
    else
      @products = Product.where(locale: I18n.locale).order(:title)
    end
  end
end
