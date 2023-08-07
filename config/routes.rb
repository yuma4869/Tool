Rails.application.routes.draw do
  #ヘッダーやHOMEなど基本
  get "/" => "index#base"
  #get "/" => "index#wait"
  get "about" => "index#about"
  get "me" => "index#me"
  get "security" => "index#security"

  #twitterフォロー欄整理ツール（selenium-webdriver）
  get 'unfollow_twitter/' => "unfollow_twitter#index"
  post 'unfollow_twitter/account' => "unfollow_twitter#account"
  get 'unfollow_twitter/unfollow_do' => "unfollow_twitter#unfollow_do"
  post 'unfollow_twitter/all_unfollow' => "unfollow_twitter#all_unfollow"
  post 'unfollow_twitter/bulk_unfollow' => "unfollow_twitter#bulk_unfollow"
  get 'unfollow_twitter/one_unfollow' => "unfollow_twitter#one_unfollow"
  get 'unfollow_twitter/follow' => "unfollow_twitter#follow"
  get 'unfollow_twitter/follow_to_unfollow' => "unfollow_twitter#follow_to_unfollow"
  post 'unfollow_twitter/delete_unfollow' => "unfollow_twitter#delete_unfollow"

  #ハッカー・エンジニア用なぞとき 名前をmathckにしたくなったからコントローラー名と違う(m_m)
  get 'mathck' => "hacker_mystery#index"
  get 'mathck/login' => "hacker_mystery#login"
  get 'mathck/account.json' => "hacker_mystery#account"

  #taskアプリ
  get 'tasks' => "tasks#index"
  get 'tasks/:name/show' => "tasks#show"
  get 'tasks/:name/total' => "tasks#total"
  post 'tasks_create' => "tasks#create"
  get 'tasks/:id/delete' => "tasks#delete"
  get 'tasks/user_all_tasks' => "tasks#user_all_tasks"
  get 'tasks/random_all_tasks' => "tasks#random_all_tasks"
  put 'tasks/:id/sort' => "tasks#sort"
  resources :tasks do 
    put :sort
  end

  #新規登録
  post 'signup' => "sessions#create"

  #ログイン用
  get 'login_form' => "sessions#new"
  post 'login' => "sessions#session_login"

  #ログアウト
  get 'logout' => "sessions#logout"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
