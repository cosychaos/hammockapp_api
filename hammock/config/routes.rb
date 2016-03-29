Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'auth'

  root 'courses#index'

  resources :courses, shallow: true do
    resources :course_modules
  end

  resources :courseitems

end
