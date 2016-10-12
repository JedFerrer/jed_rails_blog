Rails.application.routes.draw do
  #get 'users/new'
  root 'articles#all'
  resources :users do
  	resources :articles
  end
 #    resources :articles do
	#   resources :comments
	# end
  resources :sessions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
