Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # Serve websockte cable requests in-process
  # mount ActionCable.server => '/cable'

  scope "/api" do
    match '/setReady', to: 'api#setReady', via: :post
    match '/isOnline', to: "api#is_online", via: :post
    get "/online", to: "api#online"
    match "logfile", to: "api#logfile", via: :post
    get "/enc", to: "api#send_enc"
  end

  resources :course_of_studies do
    resources :courses do
      resources :students
    end
  end

  get "/courses/all", to: "courses#all"

  get "/getCourseStudents", to: "students#getCourseStudents"
  get "/dashboard", to: "students#dashboard"
  get "/stream", to: "students#index_stream"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "/logfileupload", to: 'students#add_file', as: 'upload_file'
  post "/downloadFile", to: 'students#download_file'

  root 'static#home'

end
