Rails.application.routes.draw do

  devise_for :admins, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }

  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in', as: "guest"
  end

#ユーザー側
  scope module: :public do
    root to: 'homes#top'
    get 'homes/about' => "homes#about", as: "about"

    get 'users/withdrawal' => "users#withdrawal", as: "withdrawal"
    get 'users/my_page' => "users#my_page", as: "my_page"
    patch "users/status" => "users#status", as: "status"
    resources :users, only: [:index, :show, :edit, :update] do
      member do
        get :my_list
      end
    end

    resources :posts do

      resource :favorites, only: [:create, :destroy]

      resources :comments, only: [:create, :destroy, :show]

    end
    
    resources :tags do
      resources :tag_relations, only: [:index]
    end

  end
  #管理者側
  namespace :admin do
    resources :tags, only: [:index, :edit, :create, :update, :destroy]

    resources :posts, only: [:index, :show, :destroy]

    resources :comments, only: [:index, :destroy]

    resources :users, only: [:index, :show, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
