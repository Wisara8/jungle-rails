require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it "saves with all fields valid" do
      @category = Category.new(name: "name")
      @product = Product.new(name: "name", price: 100, quantity: 1, category: @category)
      expect(@product).to be_valid
    end
    it "does not save when name is nil" do
      @category = Category.new(name: "name")
      @product = Product.new(name: nil, price: 100, quantity: 1, category: @category)
      expect(@product).to_not be_valid
    end
    it "does not save when price is nil" do
      @category = Category.new(name: "name")
      @product = Product.new(name: "name", price: nil, quantity: 1, category: @category)
      expect(@product).to_not be_valid
    end
    it "does not save when quantity is nil" do
      @category = Category.new(name: "name")
      @product = Product.new(name: "name", price: 100, quantity: nil, category: @category)
      expect(@product).to_not be_valid
    end
    it "does not save when category is nil" do
      @category = Category.new(name: "name")
      @product = Product.new(name: "name", price: 100, quantity: 1, category: nil)
      expect(@product).to_not be_valid
    end
  end
end
