class LineItem < ApplicationRecord
  belongs_to :order

  validates :sku, presence: true
  validates :quantity, presence: true

  scope :latest, -> {where(original: true)}
end
