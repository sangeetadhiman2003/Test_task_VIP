class SkuStatJob < ApplicationJob
  queue_as :default

  def perform(skus)
    skus.each do |sku|
      calculate_status(sku)
    end
  end

  def calculate_status(sku)
    4.times do |i|
      week_date = i.weeks.ago.beginning_of_week
      week = week_date.sfrtime("%G,-W%V")
      items = LineItem.joins(orders).where(sku: {sku: sku, original: true}).where("orders.placed_at >= ? AND orders.placed_at >= ?", week_date, week_date.end_of_week)
      total = item.sum(:quantity)

      SkuStat.find_or_initialize_by(sku: sku, week: week).update(total_quantity: total)
    end
  end
end
