Rails.application.routes.draw do

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords, :registrations], controllers: {
    registrations: "customer/registrations",
    sessions: 'customer/sessions'
  }
  devise_scope :customer do
    get 'signup', to: 'customer/registrations#new', as: :new_customer_registration
    post 'signup', to: 'customer/registrations#create', as: :customer_registration
  end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin,skip: [:registrations, :passwords] ,controllers: {
   sessions: "admin/sessions"
  }



  #管理者側
  namespace :admins do
    root to: 'homes#top'
    resources :customers, except: [:new, :destroy, :create]
    resources :items, except: [:destroy ]
    resources :genres, except: [:new, :destroy, :show ]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end

  #顧客側
  scope module: :public do
    root to: 'homes#top'
    get '/my_page' => 'customers#show'
    get 'about' => 'homes#about'
    resources :items, only: [:index, :show]
    resources :cart_items, except: [:new, :show, :edit] do
     collection do
      delete 'destroy_all'
     end
    end
    resources :orders, except: [:edit, :update, :destroy] do
      collection do
        post 'confirm'
        get  'complete'
      end
    end
    resource :customers, only: [:edit, :update] do
      collection do
        get 'confirm'
        patch 'quit'
      end
    end
    resources :addresses, except: [:show, :new]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
