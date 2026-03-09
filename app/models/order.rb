class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy

  validates :sku, presence: true, uniqueness: true
  validates :quantity, presence: true

  def locked?
    locked_at.present?
  end

  def correction_window_expire
    created_at< 15.minutes.ago
  end

end
