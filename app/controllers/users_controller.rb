class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index


=begin
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
=end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
=begin 
 # parsed_json = ActiveSupport::JSON.decode(params)
  #@data =  parsed_json;
    #params=JSON.parse(params);
    #puts(params['myDATA']);
    @data=JSON.parse(params['myDATA']);
    
    @info = Hash.new
    @info= @data['info'];
    @info.syncDate= Time.now.to_i;

#    User.find(:all, :conditions => ["CAST(strftime('%s',updated_at) as integer)< ?",Time.now.to_i])


    @response= Hash.new
    @user= User.find_or_create_by_username_and_email_and_password(@data['info']['username'],@data['info']['email'],@data['info']['password']);
    
    @response['status']="find users"     
    @response['user']=@user  

      respond_to do |format|
            format.html { redirect_to @data, notice: 'User was successfully created.' }
            format.json { render json:@response }
        end
    

   @user= User.find(params['info']['id']);

    respond_to do |format|
        format.html { redirect_to @data, notice: 'User was successfully created.' }
        format.json { render json:params['info'] }
    end
=end

    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
