Rails.application.routes.draw do
  namespace :api do
    resources :mon_thi
    resources :thi_sinh
    resources :de_thi
    resources :cau_hoi
    resources :thi
    resources :dap_an
    resources :ket_qua

    post  '/thi_sinh/dang_nhap'   => 'thi_sinh#dang_nhap'
    post  '/thi_sinh/dang_xuat'   => 'thi_sinh#dang_xuat'

    get   '/de_thi/:id/list'      => 'de_thi#list_by_mon_thi'

    # { "dcau_hoi_ide_thi_id": "id", "": "id" }
    post  '/de_thi/add_cau_hoi'   => 'de_thi#add_cau_hoi'
    delete '/de_thi/:dt_id/:ch_id' => 'de_thi#delete_cau_hoi'

    get   '/cau_hoi/:id/list'     => 'cau_hoi#list_by_de_thi'
    get   '/cau_hoi/:id/list_with_da' => 'cau_hoi#list_with_da'

    post '/thi/begin'             => 'thi#bat_dau_thi'
    post '/thi/end'               => 'thi#thi_xong'
    get  '/thi/diem/:id'          => 'thi#diem'
    get  '/thi/ket_qua/:id'         => 'thi#check_result'
  end

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
