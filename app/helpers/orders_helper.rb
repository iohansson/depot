module OrdersHelper
  def payment_type_options
    options_for_select(Order::PAYMENT_TYPES.map {|x| I18n.t("order.payment_types."+x.parameterize.underscore)})
  end
end
