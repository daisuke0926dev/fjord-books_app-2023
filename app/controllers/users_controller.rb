# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users or /users.json
  def index
    @users = User.order(:email).page(params[:page]).per(3)
  end

  # GET /users/1 or /users/1.json
  def show; end

  # GET /users/new
  def new; end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create; end

  # PATCH/PUT /users/1 or /users/1.json
  def update; end

  # DELETE /users/1 or /users/1.json
  def destroy; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :encrypted_password, :post_code, :addr, :biography)
  end
end
