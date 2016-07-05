Rails.application.routes.draw do

  resources :course_of_studies do
    resources :courses do
      resources :students
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'course_of_studies#index'
end
