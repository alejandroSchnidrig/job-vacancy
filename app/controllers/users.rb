JobVacancy::App.controllers :users do
  
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end

  get :new, :map => '/register' do
    if signed_in?
     flash[:error] = 'You can not sign up if you are logged in'
     redirect '/' 
    end
    @user = User.new
    render 'users/new'
  end

  post :create do
      password_confirmation = params[:user][:password_confirmation]
      params[:user].reject!{|k,v| k == 'password_confirmation'}
      @user = User.new(params[:user])
      if (params[:user][:password] == password_confirmation)
        unless @user.verify_password_is_strong(password_confirmation)
           flash.now[:error] = 'weak password entered'
           render 'users/new'
        else
            if @user.save
              flash[:success] = 'User created'
              redirect '/'
            else
              flash.now[:error] = 'All fields are mandatory'
              render 'users/new'
            end
        end
      else
        flash.now[:error] = 'Passwords do not match'
        render 'users/new'          
      end
  end

  get :password_generator do
    @user =  User.new
    @password_generator = PasswordGenerator.new
    render 'users/password_generator'
  end

   post :send do  
    user_email = params[:password_generator][:user_email]
    @user = User.first(:email => user_email)
    if @user == nil
      flash[:error] = 'User not exist'
      redirect '/login'
    else  
      @new_password = @user.new_password
      @user.password= (@new_password)
      @user.save
      @password_generator = PasswordGenerator.create_for(user_email, @new_password)
      @password_generator.process
      flash[:success] = 'New password sent'
      redirect '/login'
    end
  end

end
