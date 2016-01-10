Rails.application.routes.draw do
  root 'search#index'
  get 'search/query', as: :search_query
end
