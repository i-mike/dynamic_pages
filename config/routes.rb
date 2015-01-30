Rails.application.routes.draw do

  get 'admin', to: redirect("/#{I18n.default_locale}/admin", status: 302), as: :admin_root

  scope '/:locale', constraints: LocalizationConstraint.new do
    devise_for :users

    scope module: :common do
      resources :pages, only: [:index, :show]
      get '' => 'pages#index'
    end

    namespace :admin do
      resources :pages do
        resources :page_contents
      end

      resources :languages

      get '' => 'pages#index'
    end
  end

  root to: Common::PagesController.action(:index)
end
