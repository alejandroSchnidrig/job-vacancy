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

end
