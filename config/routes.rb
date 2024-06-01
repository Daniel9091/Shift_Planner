Rails.application.routes.draw do
  root 'home#index'                   # nesesario para devise

  get 'login', to: 'sessions#login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users, only: [:new, :create]
  get 'perfil', to: 'home#index'
  get 'viaje', to: 'home#viajes'
  get 'global', to: 'home#global'
  post 'join_group/:id', to: 'home#join_group', as: 'join_group'

  post 'itineraries/:id/toggle_active', to: 'itineraries#toggle_active', as: 'toggle_active_itinerary'
  get 'itineraries/:id/delete', to: 'itineraries#delete', as: 'delete_itinerary'
  resources :itineraries, only: [:new, :create, :destroy]

  get 'section_groups/:id/delete', to: 'section_groups#delete', as: 'delete_section_groups'
  get 'section_groups/:id/leave', to: 'section_groups#leave', as: 'leave_section_groups'
  resources :section_groups

end