JobVacancy::App.controllers :job_offers do
  
  get :my do
    @offers = JobOffer.find_by_owner(current_user)
    render 'job_offers/my_offers'
  end    

  get :index do
    @offers = JobOffer.all_active
    render 'job_offers/list'
  end  

  get :new do
    @job_offer = JobOffer.new
    render 'job_offers/new'
  end

  get :latest do
    @offers = JobOffer.all_active
    render 'job_offers/list'
  end

  get :edit, :with =>:offer_id  do
    @job_offer = JobOffer.get(params[:offer_id])
    render 'job_offers/edit'
  end

  get :apply, :with =>:offer_id  do
    @job_offer = JobOffer.get(params[:offer_id])
    @job_application = JobApplication.new
    render 'job_offers/apply'
  end

  get :share, :with =>:offer_id  do
    @job_offer = JobOffer.get(params[:offer_id])
    @job_sharing = JobSharing.new
    render 'job_offers/share'
  end

  post :search do
    field = params[:q].strip.downcase
    @search_tool = SearchTool.new
    if field.include?":" 
      if (field.include?("title:") || field.include?("location:") || field.include?("description:"))
        @offers = @search_tool.search(field)
        render 'job_offers/list' 
      else
        flash[:error] = 'Invalid search filed'
        redirect 'job_offers/latest'
      end  
    else
      @offers = @search_tool.default_search_title(field)
      render 'job_offers/list'
    end
  end

  post :apply, :with => :offer_id do
    @job_offer = JobOffer.get(params[:offer_id])    
    applicant_email = params[:job_application][:applicant_email]
    link_cv = params[:job_application][:link_cv]
    @job_application = JobApplication.create_for(applicant_email, link_cv, @job_offer)
    valid_cv = @job_application.valid_cv?(link_cv) 
    unless  valid_cv
      flash.now[:error] = 'CV link is mandatory'
       render '/job_offers/apply'
    else
        valid_email = @job_application.valid_email?(applicant_email) 
        if valid_email
          @job_application.process_to_applicant
          @job_application.process_to_offerer
          flash[:success] = 'Contact information sent'
          redirect '/job_offers'
        else
          flash.now[:error] = 'Invalid email direction'
          render '/job_offers/apply'
        end  
      end
  end

  post :send, :with => :offer_id do
    @job_offer = JobOffer.get(params[:offer_id])    
    contact_email = params[:job_sharing][:contact_email]
    comments = params[:job_sharing][:comments]
    @job_sharing = JobSharing.create_for(contact_email, comments, @job_offer)
    valid_email = @job_sharing.valid_email?(contact_email) 
    if valid_email
      @job_sharing.process
      flash[:success] = 'Offer information sent'
      redirect '/job_offers'
    else
      flash.now[:error] = 'Invalid email direction'
      render '/job_offers/share'
    end  
  end

  get :find_near do
    @job_offer = JobOffer.get(params[:offer_id])
    @search_tool = SearchTool.new
    @offers = @search_tool.default_search_location(@job_offer.latitude,@job_offer.longitude,@job_offer.location) 
    render 'job_offers/list'
  end

  get :title do
    @offers = JobOffer.all(:order => [ :title.asc ])
    render 'job_offers/list'
  end 

  get :location do
    @offers = JobOffer.all(:order => [ :location.asc ])
    render 'job_offers/list'
  end  

  post :create do
    @job_offer = JobOffer.new(params[:job_offer])
    @job_offer.owner = current_user
    @job_offer.latitude = (params[:job_offer][:latitude].try(:empty?)) ? nil : params[:job_offer][:latitude]
    @job_offer.longitude = (params[:job_offer][:longitude].try(:empty?)) ? nil : params[:job_offer][:longitude]
    if @job_offer.save
      if params['create_and_twit']
        TwitterClient.publish(@job_offer)
      end
      flash[:success] = 'Offer created'
      redirect '/job_offers/my'
    else
      @job_offer.errors.each do |e|
       flash.now[:error] = 'Error in post :create - ' +  e.to_s
     end
      render 'job_offers/new'
    end  
  end

  post :update, :with => :offer_id do
    @job_offer = JobOffer.get(params[:offer_id])
    @job_offer.update(params[:job_offer])
    @job_offer.latitude = (params[:job_offer][:latitude].empty?) ? nil : params[:job_offer][:latitude]
    @job_offer.longitude = (params[:job_offer][:longitude].empty?) ? nil : params[:job_offer][:longitude]
    if @job_offer.save
      flash[:success] = 'Offer updated'
      redirect '/job_offers/my'
    else
       @job_offer.errors.each do |e|
       flash.now[:error] = 'Error in post :update - ' +  e.to_s
     end
      #flash.now[:error] = 'Error in post :update - ' + text
      render 'job_offers/edit'
    end  
  end

  put :activate, :with => :offer_id do
    @job_offer = JobOffer.get(params[:offer_id])
    @job_offer.activate
    if @job_offer.save
      flash[:success] = 'Offer activated'
      redirect '/job_offers/my'
    else
      flash.now[:error] = 'Operation failed'
      redirect '/job_offers/my'
    end  
  end

  delete :destroy do
    @job_offer = JobOffer.get(params[:offer_id])
    if @job_offer.destroy
      flash[:success] = 'Offer deleted'
    else
      flash.now[:error] = 'Error in post :destroy '
    end
    redirect 'job_offers/my'
  end

end
