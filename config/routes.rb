# frozen_string_literal: true

Rails.application.routes.draw do
  resources :patients, only: %i[index show create update destroy] do
    resources :documents, only: %i[index show create update destroy]
  end
end
