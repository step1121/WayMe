Rails.application.routes.draw do

  #下記管理者側
  devise_for :admin, controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do

    resources :genres, only: [:index, :create, :update, :edit]
    resources :visions, only: [:index, :show, :destroy]

    resources :users, only: [:index, :show, :update] do
      collection do
        patch '/out/:id' => 'users#out', as: "out"
      end
    end
  end

  #ここから下記ユーザー側
  #トップページでログイン可能
  devise_scope :user do
      root :to => 'public/sessions#new'
  end

  devise_for :users, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }

  scope module: :public do

    get 'users/search' => 'searchs#search_user'
    get 'visions/search' => 'searchs#search_vision'
    resources :visions do
      resources :tasks, except: [:new, :show, :index]
      patch 'tasks/:id/complete' => 'tasks#complete', as: "complete"
    end

    resources :users, only: [:edit, :update, :show] do
      collection do
        get '/out_check' => 'users#out_check'
        patch '/out' => 'users#out'
      end
      resource :relationships, only: [:create, :destroy]
      get 'index' => 'relationships#index', as: 'follow'
    end

  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
