Webagency::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  devise_for :users, :controllers => { :sessions => "users/sessions",:registrations => "users/registrations" }, :path_names =>  {:sign_up=>'new',:sign_in => 'login', :sign_out => 'logout'} do
    get '/users', :to => 'users/registrations#index'
    get '/login', :to => 'users/sessions#new'      
  end

  resources :products
  resources :templates
  resources :template_categories
  resources :template_types  
  resources :template_authors
  resources :template_packages  
  resources :projects
  resources :portfolios
  resources :maintain
  resources :company
  resources :histories
  
  namespace :customer_center do
    resources :faqs
    resources :faq_categories
    resources :guest_books do
      resources :guest_book_comments
    end
    resources :questions do
      resources :question_comments
    end 
    resources :contacts
    resources :notices
  end

  namespace :admins do
    resources :products, :templates, :template_authors, :template_packages, :template_softwares, :template_categories, :template_sources, :template_types
    resources :intro, :menus, :notices, :gallery_categories, :galleries, :faq_categories,:faqs, :guest_books
    resources :questions do
      resources :question_answers
    end
  end  
  
  root :to => 'home#index'
end
