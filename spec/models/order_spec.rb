require 'spec_helper'

describe Order do
  context 'validations' do
    before do
      @order = FactoryGirl.create(:order)
    end
    %w(email address name).each do |attr|
      it "must have #{attr}" do
        @order.send("#{attr}=",nil)
        expect(@order).not_to be_valid
        expect(@order.errors[attr]).not_to be_nil
      end
    end
  end
  it 'should create order' do
    @valid_attrs = FactoryGirl.attributes_for(:order)
    expect{Order.create(@valid_attrs)}.to change{Order.count}.by(1)
  end
end
