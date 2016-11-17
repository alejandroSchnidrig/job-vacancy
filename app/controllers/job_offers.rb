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

  get :clone, :with =>:offer_id do
    @job_offer_old = JobOffer.get(params[:offer_id])
    @job_offer = JobOffer.new
    @job_offer.title = 'copy of ' + @job_offer_old.title
    @job_offer.location = 'copy of ' + @job_offer_old.location
    @job_offer.description = 'copy of ' + @job_offer_old.description
    @job_offer.latitude = @job_offer_old.latitude
    @job_offer.longitude = @job_offer_old.longitude
    render 'job_offers/clone'
  end

  post :search do
    field = params[:q].strip.downcase
    @search_tool = SearchTool.new
    if field.include?":" 
      if (field.include?("title:") || field.include?("location:") || field.include?("description:"))
        @offers = @search_tool.search(field)
        render 'job_offers/list' 
      else
        flash[:error] = 'Invalid search field'
        redirect 'job_offers/latest'
      end  
    else
      @offers = @search_tool.default_search_title(field)
      render 'job_offers/list'
    end
  end

  post :apply, :with => :offer_id do
    @job_offer = JobOffer.get(params[:offer_id])  
    owner_email_address = ''
    #owner_email_address = JobOffer.get_email
    applicant_email = params[:job_application][:applicant_email]
    link_cv = params[:job_application][:link_cv]
    @job_application2 = JobApplication.create_for(applicant_email, link_cv, @job_offer)
    owner_email_address = @job_application2.job_offer.owner.email

    # applicant_email = params[:job_application][:applicant_email]
    #   owner_email = ''
    #   if signed_in? 
    #     owner_email = current_user.email
    #   end

   # if @job_offer.owner.email.to_s.eql?(applicant_email.to_s)   #current_user.to_s
  #estaba ok  if owner_email.to_s.eql?(applicant_email.to_s)
   if owner_email_address.to_s.eql?(applicant_email.to_s)
       flash[:error] = 'You can not apply to your own offer!' #+ owner_email_address.to_s
       #render '/job_offers/apply'
       redirect '/job_offers'
    #end
    else
        #link_cv = params[:job_application][:link_cv]
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
              flash[:success] = 'Contact information sent' # +  owner_email_address.to_s #+ owner_email.to_s + '**' + applicant_email.to_s #+ @job_offer.owner.email.to_s + applicant_email.to_s
              redirect '/job_offers'
            else
              flash.now[:error] = 'Invalid email direction'
              render '/job_offers/apply'
            end  
          end
      end
    end

  post :clone do
    @job_offer = JobOffer.new(params[:job_offer])
    @job_offer.created_on = Date.today
    @job_offer.owner = current_user
    if @job_offer.save
      flash[:success] = 'Offer cloned correctly'
      redirect '/job_offers/my'
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

  get :created_on do
    @offers = JobOffer.all(:order => [ :created_on.desc ])
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
       flash.now[:error] = e.to_s
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
       flash.now[:error] = e.to_s
     end
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
