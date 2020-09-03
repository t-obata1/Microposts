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
      get :favorites
    end
    # collection do
    #   get search
    # end
  end
  
  
  
  #アクションなのでviewやshowはいらない
  resources :microposts, only:[:create, :destroy] #投稿する、投稿を消す
  resources :relationships, only: [:create, :destroy] #フォローする、フォロー取り消す
  resources :favorites, only: [:create, :destroy] #ふぁぼる、ふぁぼを取り消す
end
