Rails.application.routes.draw do
  namespace :public do
    get 'tags/index'
  end
  namespace :admin do
    get 'tags/index'
  end
  namespace :admin do
    get 'comments/index'
  end
  namespace :admin do
    get 'posts/index'
    get 'posts/show'
  end
  namespace :admin do
    get 'users/index'
    get 'users/show'
  end
  namespace :public do
    get 'tag_relations/index'
  end
  namespace :public do
    get 'comments/index'
  end
  namespace :public do
    get 'favorites/index'
  end
  namespace :public do
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
    get 'posts/new'
  end
  namespace :public do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
    get 'users/my_page'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
