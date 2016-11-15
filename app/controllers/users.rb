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
           flash.now[:error] = 'Weak password entered'
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

  get :password_recovery do
    @user =  User.new
    @code_generator = CodeGenerator.new
    render 'users/password_recovery'
  end

  post :send do  
    user_email = params[:code_generator][:user_email]
    @user = User.first(:email => user_email)
    if @user == nil
      flash[:error] = 'User not exist'
      redirect '/login'
    else  
      @code = @user.generate_code
      @user.code = @code
      @user.save
      @code_generator = CodeGenerator.create_for(user_email, @code)
      @code_generator.process
      flash.now[:success] = 'Code sent'
      render 'users/password_recovery'
    end
  end

  get :password_change do
    @user =  User.new
    render 'users/password_change'
  end

  post :apply_password do
    user_code = params[:user][:code]
    new_password = params[:user][:password]
    password_confirmation = params[:user][:password_confirmation]
    @user = User.first(:code => user_code)
    if @user == nil
      flash[:error] = 'Incorrect code, please try again!'
      redirect 'users/password_recovery'
    elsif (new_password != password_confirmation)
      flash[:error] = 'Passwords do not match'
      redirect 'users/password_recovery'
    elsif ((@user.code == user_code) && (new_password == password_confirmation))
      if @user.verify_password_is_strong(password_confirmation) == false
        flash[:error] = 'Weak password entered, please try again!'
        redirect 'users/password_recovery'
      else
        @user.password= (new_password)
        @user.code = nil
        @user.save
        flash[:success] = 'New password create'
        redirect '/login'
      end  
    end   
  end

end
