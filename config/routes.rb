Rails.application.routes.draw do
  get 'day_of_week/index'
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
  get 'tasks/user_all_tasks' => "tasks#user_all_tasks"
  get 'tasks/random_all_tasks' => "tasks#random_all_tasks"
  post 'tasks_create' => "tasks#create"
  get 'tasks/:name/show' => "tasks#show"
  get 'tasks/:name/total' => "tasks#total"
  get 'tasks/:id/delete' => "tasks#delete"
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

  #コラッツ予想
  get 'collatz' => "collatz#index"
  post 'collatz/number' => "collatz#number"
  post 'collatz/music' => "collatz#music"

  #曜日計算器
  get 'day_of_week' => "day_of_week#index"
  post 'day_of_week/get' => "day_of_week#get"


  #seeniumテスト
  get "selenium" => "day_of_week#selenium"
  post "selenium/url" => "day_of_week#selenium_url"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
