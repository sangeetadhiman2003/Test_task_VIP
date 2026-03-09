class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  validates :external_id, presence: true, uniqueness: true

  def locked?
    locked_at.present?
  end

  def correction_window_expire
    created_at< 15.minutes.ago
  end

end
