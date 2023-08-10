Rails.application.routes.draw do
  get 'approval_requests/approve'
  get 'approval_requests/refuse'
  get 'approve/refuse'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#top"

  resources :families, only: %i[new create show edit update] do
    resources :users, only: %i[new create edit update destroy]
    resource :user_profile, only: %i[show edit update]
    resources :tasks do
      get :menu, on: :collection
      post :task_users, to: 'task_users#create', on: :member
      delete :task_users, to: 'task_users#destroy', on: :member
    end
    resources :categories
    resources :task_users, only: %i[create destroy]
    resources :notices, only: %i[create index show destroy] do
      get :show_approval_request
    end
    resources :records do
      get :task_show, on: :member
      get :task_index, on: :member
    end
    get :configuration
    get :modify_budget
    get :invitation
    post :approve, to: 'approval_requests#approve', on: :member
    post :refuse, to: 'approval_requests#refuse', on: :member
  end
  resource :family_profile, only: %i[show edit update]

  get :invited, to: 'invited_users#new'
  post :invited, to: 'invited_users#create'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  # Defines the root path route ("/")
  # root "articles#index"
end
