class Api::V1::OrdersController < ApplicationController

  def create
   order = Order.find_by(external_id: params[:external_id])

    if order.present?
      return render_locked_error(order)
      if order.locked?
        ActiveRecord::Base.transaction do
          order.line_items.update_all(original: false)
          create_line_item(order)
        end
      else
        order = Order.new(orders_params)
        order.save
        create_line_item(order)
      end
    end
    enqueue_sku_job(order)
    render json: {success: true, message: "Order Created"}
  end

  def lock
    order = Order.find_by(id: params[:id])
    order.update(locked_at: Time.current)
    enqueue_sku_job(order)
    render json: {success: true, message: "Oder locked."}
  end

  private

  def orders_params
    params.require(:order).permit(:external_id, :placed_at, :locked_at )
  end

  def create_line_item(order)
    params[:line_items].each do |item|
      order.line_items.create(sku: item[:sku], quantity: item[:quantity], original: true)
    end
  end

  def render_locked_error(order)
    render json: {error: "LockedForEdit"}
  end

  def enqueue_sku_job(order)
    skus = order.line_items.pluck(:sku).uniq
    SkuStatJob.perform_later(skus)
  end

end
