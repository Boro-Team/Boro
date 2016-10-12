Rails.application.routes.draw do
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" , registrations: "users/registrations", sessions: 'users/sessions'}

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  resources :users, controller: 'users', only: [:show, :edit, :update, :destroy, :index] 
  
  resources :items do
    resources :rentals, :only => [:create, :new, :show]
  end
  
   get "/items/tags/:tag_id" => "items#tag", as: "tags"
   get '/search', to: 'items#search'

  # mailbox folder routes
  get "mailboxes/inbox" => "mailboxes#inbox", as: :mailboxes_inbox
  get "mailboxes/sent" => "mailboxes#sent", as: :mailboxes_sent
  get "mailboxes/archive" => "mailboxes#archive", as: :mailboxes_archive

  # conversations
  resources :conversations do
    member do
      post :reply
      post :archive
      post :unarchive
    end
  end

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
