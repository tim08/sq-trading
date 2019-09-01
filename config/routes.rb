Rails.application.routes.draw do
  resources :product_items do
    member do
      get 'to_sell'
      put 'update_sell'
      put 'withdraw_from_sale'
      put 'to_advertise'
      put 'buy'
    end
  end
  resources :products
  resources :players do
    member do
      get 'store'
      get 'market'
    end
    :store
  end
  root 'main#index'
  get 'adv_board', to: 'main#adv_board'

  post 'sing_in', to: 'main#create_session'
  delete 'sing_out', to: 'main#destroy_session'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
