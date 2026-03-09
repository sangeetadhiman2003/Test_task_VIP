require 'rails_helper'

RSpec.describe Order, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "it is in valid without unique exernal_id" do
   Order.create(external_id:"123Order", placed_at: Time.now)
   order = Order.new(external_id: "123Order", placed_at: Time.now)
   expect(order.valid?). to be false
  end

  it "invalid without external_id" do
    order = Order.new(placed_at: Time.now)
    expect(order). not_to be_valid
  end

end
