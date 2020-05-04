class UsersController < ApplicationController
  require 'nylas'
  require 'oauth2'
  require 'signet/oauth_2/client'

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    #binding.pry
  end

  def mail_details
    # binding.pry
    @user = User.find(params[:user_id])
    messages = nylas(@user.nylas_token).messages.limit(10)

    # from = message.from.first.attributes.data.registry_data[:email]
    # id = message.id
    # subject = message.subject
    # snippet = message.snippet
    # body = message.body



  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new
    begin
      auth_hash = request.env['omniauth.auth']
      user_data = auth_hash[:info]
      user_credentials = auth_hash[:credentials]
      @user.name = user_data.name
      @user.image = user_data.image
      @user.email = user_data.email
      @user.connected_email = user_data.email
      @user.refresh_token = user_credentials.refresh_token
      @user.email_connection_date = Date.today
      @user.uid = auth_hash.uid
      @user.email_provider = auth_hash.provider

      respond_to do |format|
        if @user.save
          connect_nylas(auth_hash, @user)
          format.html { redirect_to @user, notice: 'User was successfully created.' }
          format.json { render :index, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end

    rescue Exception => e
          format.html { render :new }
          format.json { render json: e, status: :unprocessable_entity }
    end

  end

  def connect_nylas(auth_hash, user)
    nylas_token = nylas.authenticate(
        name: auth_hash[:info][:name],
        email_address: auth_hash[:info][:email],
        provider: :gmail,
        settings: {
          google_client_id: ENV['GOOGLE_CLIENT_ID'],
          google_client_secret: ENV['GOOGLE_CLIENT_SECRET'],
          google_refresh_token: auth_hash[:credentials][:refresh_token]
        },
        scopes: 'email.read_only'
      )
    # nylas_account_id
    user.update_attributes(nylas_token: nylas_token, nylas_account_id: nylas(nylas_token).current_account.id) if nylas_token.present?
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def connect_callback
    binding.pry
  end

  def disconnect_callback
    user = User.find(params[:user_id])
    if user.present?
      begin
        nylas.revoke(user.nylas_token)
        account = nylas.accounts.find(user.nylas_account_id)
        account.downgrade
        user.destroy
      rescue Exception => e
        puts "has some error #{e}"
      end
    end
    redirect_to root_path
  end


  def login_callback
    binding.pry
  end


  private

    def nylas(nylas_token = nil)
      Nylas::API.new(
        app_id: ENV['NYLAS_APP_ID'],
        app_secret: ENV['NYLAS_APP_SECRET'],
        access_token: nylas_token
      )
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :image, :email, :connected_email, :refresh_token, :email_connection_date, :uid, :email_provider)
    end
end
