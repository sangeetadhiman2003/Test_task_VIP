Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :orders, only: [:create] do
        post :lock, on: :member
      end
      get "sku-summary/:sku",  to: "sku_stats#show"
    end
  end
end
