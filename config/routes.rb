Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "toppages#index"
  
  #ログイン機能
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  

  get "signup", to: "users#new"
  
  resources :users, only:[:index,:show,:new,:create] do
    member do
      get :followings
      get :followers
      get :likes #userがふぁぼっている投稿一覧のページ /users/:id/favorites(.:format)  
    end
  end
  

  #アクションなのでviewやshowはいらない
  resources :microposts, only:[:create, :destroy] #do
    #resource :favorites, only: [:create, :destroy]
  #end
  
  resources :relationships, only: [:create, :destroy] #フォローする、フォロー取り消す
  resources :favorites, only: [:create, :destroy] #お気に入りする、お気に入りを取り消す
end
