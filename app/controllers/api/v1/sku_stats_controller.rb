class Api::V1::SkuStatsController < ApplicationController

  def show
    sku_stats = SkuStat.where(sku: params[:sku])
    result = sku_stats.map do |s|
      {
        week: s.week,
        quantity: s.total_quantity
      }
    end
    render json: {success: true, result: result}
  end

end
