# frozen_string_literal: true

class RegistrationController < ApplicationController
  def account_update
    super
    resource.avatar.attach(account_update_params[:avatar]) if account_update_params[:avatar].present?
  end
end
