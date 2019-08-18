Rails.application.routes.draw do
  root 'repos#index'
  post 'repos/search' => 'repos#search'
  post 'repos/paginate' => 'repos#paginate'
end
