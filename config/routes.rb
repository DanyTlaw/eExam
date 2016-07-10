Rails.application.routes.draw do

  # Serve websockte cable requests in-process
  # mount ActionCable.server => '/cable'

  scope "/api" do
    match '/apitest', to: 'api#apitest', via: :post
    get "/apiget", to: "api#apigettest"
    match '/isOnline', to: "api#is_online", via: :post
    get "/online", to: "api#online"
  end

  resources :course_of_studies do
    resources :courses do
      resources :students
    end
  end

  get "/dashboard", to: "students#dashboard"
  get "/stream", to: "students#index_stream"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'course_of_studies#index'

end
