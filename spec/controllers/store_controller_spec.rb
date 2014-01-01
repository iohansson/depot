require 'spec_helper'

describe StoreController do
  before do
    @products = {en: FactoryGirl.create(:product, locale: 'en'), es: FactoryGirl.create(:product, locale: 'es')} 
  end
  %w(en es).each do |locale|
    it "should display only #{locale} products for locale #{locale}" do
      get :index, locale: locale
      expect(assigns[:products]).to eq([@products[locale.to_sym]])
    end
  end 
end 
