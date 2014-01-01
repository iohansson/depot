class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  PAYMENT_TYPES = [
    "Check",
    "Credit card",
    "Purchase order" 
  ]
  attr_accessible :address, :email, :name, :pay_type
  
  validates_presence_of :address, :email, :name
  validates :pay_type, inclusion: PAYMENT_TYPES
  
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
  
  def no_ship_date
    self.ship_date.nil?
  end
  
  def send_new_ship_email
    OrderNotifier.shipped(self).deliver
  end
  
  def send_ship_changed_email
    OrderNotifier.ship_changed(self).deliver
  end
  
  after_update :send_new_ship_email, :if => :ship_date_changed? && :no_ship_date
  after_update :send_ship_changed_email, :if => :ship_date_changed? && :ship_date_was
end
