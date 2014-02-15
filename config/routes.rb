Infocongress::Application.routes.draw do
resources :electeds do
  resources :electeds_users, only: [:create, :destroy]
end

resources :committees
resources :users

get "/login", to: "session#new"
post "/session", to: "session#create"
delete "/session", to: "session#destroy"

end
