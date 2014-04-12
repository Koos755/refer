Refer::Application.routes.draw do

  root 'home#index'

  get "wizard/step1", as: 'step1'
  post "wizard/step1/create" => 'wizard#step1_create', as: 'step1_create'
  get "wizard/step2", as: 'step2'
  post "wizard/step2/create" => 'wizard#step2_create', as: 'step2_create'
  get "wizard/step3", as: 'step3'
  post "wizard/step3/create" => 'wizard#step3_create', as: 'step3_create'
  get "wizard/step4", as: 'step4'
  post "wizard/step4/create" => 'wizard#step4_create', as: 'step4_create'
  get "wizard/step5", as: 'step5'

  get 'about/index' => 'about#index', as: 'about_index'

  get "sessions/new" => 'sessions#new'
  post "sessions/" => 'sessions#create', as: 'sessions'
  delete "sessions/" => 'sessions#destroy'
  get "users/new"
  get "users/show"
  get "users/edit"
  get "users/create"
  get "users/update"

  get "token/:value" => 'token#value', as: 'token'

  get "lead_accept/agent/step1" => 'lead_accept#agent', as: 'agent_step1'
  get "lead_accept/agent/step2" => 'lead_accept#agent_step2', as: 'agent_step2'
  post "lead_accept/agent/step3" => 'lead_accept#agent_step3', as: 'agent_step3'
  get "lead_accept/broker/step1" => 'lead_accept#broker', as: 'broker_step1'
  post "lead_accept/agent_reply", as: 'agent_reply'
  post "lead_accept/broker_reply", as: 'broker_reply'

  get 'sessions/reset' => 'sessions#request_reset', as: 'reset'
  post 'sessions/reset' => 'sessions#submit_reset'
  delete 'sessions/reset' => 'sessions#new_password'
  get 'sessions/set_password' => 'sessions#set_password', as: 'set_password'

  resources :leads
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
