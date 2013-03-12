RubyKaigi2013::Application.routes.draw do
  scope '2013' do
    root to: 'top#show'
    resources :talks, only: %w[index show]
    resources :pages, only: %w[show]
    match '/:page_name', to: 'pages#show', as: :page_name
  end
end
