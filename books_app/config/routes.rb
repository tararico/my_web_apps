Rails.application.routes.draw do
  root to: redirect('/books')
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'}
  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
