# frozen_string_literal: true

Rails.application.routes.draw do
  root 'homes#index'

  # BEGIN
  resources :posts, shallow: true do
    scope module: :posts do
      resources :comments, only: %i[create edit update destroy]
    end
  end
  # END
end
