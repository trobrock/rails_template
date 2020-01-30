# frozen_string_literal: true

require 'resque/server'
require 'resque/scheduler/server'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Resque::Server.new, at: '/resque', constraints: AdminConstraint.new

  devise_for :users

  root to: 'home#index'
end
