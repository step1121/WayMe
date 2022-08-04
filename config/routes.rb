Rails.application.routes.draw do

  namespace :admin do
    resources :genres, only: [:index, :create, :update]
    resources :visions, only: [:index, :show, :destroy]
    resources :users, only: [:index, :show, :update] do
      collection do
        patch 'users/out' => 'users#out'
      end
    end
  end
  
  devise_for :admin, skip: [:registrations,:passwords], controllers: {
    sessions: 'admin/sessions'
  }
  
  scope module: :public do
    get '/search' => 'searchs#search'
    resources :visions do
      resources :tasks, except: [:new, :show, :index]
    end
    resources :user, only: [:edit, :update, :show] do
      collection do
        get 'users/out_check' => 'users#out_check'
        patch 'users/out' => 'users#out'
      end
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers'  => 'relationships#followers', as: 'followers'
    end
  end
  
  #トップページでログイン可能
  unauthenticated do
    as :user do
      root :to => 'public/sessions#new'
    end
  end
   
  devise_for :users, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
