class Product < ApplicationRecord
  has_and_belongs_to_many :categories

  has_many :order_items
  has_many :orders, through: :order_items
  has_many :variants
  has_many :sizes, through: :variants
  has_many :colors, through: :variants

  def self.products_with_stock
    products_with_stock = []
    self.all.each do |product|
      if product.variants.first && product.variants.first.stock > 0
        products_with_stock << product
      end
    end
    products_with_stock
  end

  def visible_on_catalog?
    variants.each do |variant|
      if variant.stock > 0
        return true
      end
    false
  end
end

end