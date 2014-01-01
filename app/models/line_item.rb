class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :cart
  attr_accessible :product, :product_id, :cart_id, :price
  
  def total_price
    product.price * quantity
  end
end
