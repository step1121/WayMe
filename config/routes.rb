Rails.application.routes.draw do
  
  devise_for :admin, controllers: {
    sessions: 'admin/sessions'
  }
  

  namespace :admin do
    resources :genres, only: [:index, :create, :update, :edit]
    resources :visions, only: [:index, :show, :destroy]
    resources :users, only: [:index, :show, :update] do
      collection do
        patch 'users/out' => 'users#out'
      end
    end
  end
  
  #トップページでログイン可能
  devise_scope :user do
      root :to => 'public/sessions#new'
  end
   
  devise_for :users, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }
  
  scope module: :public do
    get '/search' => 'searchs#search'
    resources :visions do
      resources :tasks, except: [:new, :show, :index]
    end
    resources :users, only: [:edit, :update, :show] do
      collection do
        get 'users/out_check' => 'users#out_check'
        patch 'users/out' => 'users#out'
      end
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers'  => 'relationships#followers', as: 'followers'
    end
  end
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
