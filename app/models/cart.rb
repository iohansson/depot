class Cart < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :line_items, :dependent => :destroy 
  
  def add_product(product_id)
    current_item = line_items.find_by_product_id(product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product_id, price: Product.find(product_id).price)
    end
    current_item
  end
  
  def remove_item(item_id)
    item = line_items.find(item_id)
    if item.quantity > 1
      item.quantity -= 1
    else
      item.destroy
    end
    item
  end
  
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
end
