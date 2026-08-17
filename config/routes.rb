Rails.application.routes.draw do
  resources :gifts, only: [ :index, :show ], param: :slug do
    resources :contributions, only: [ :new, :create ]
  end

  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  root "gifts#index"
end
