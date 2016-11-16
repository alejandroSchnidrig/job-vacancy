class SearchTool

	def search(field)
	  @offers = JobOffer.new	
      new_field = field.partition(":").last.strip 
          if field.include?"location:"
            @offers = JobOffer.all(:location.like => "%"+new_field+"%") 
          elsif field.include?"description:"
            @offers = JobOffer.all(:description.like => "%"+new_field+"%")
          elsif field.include?"title:"
            @offers = JobOffer.all(:title.like => "%"+new_field+"%")
          end  
      @offers      
    end

    def default_search_title(field)
      @offers = JobOffer.new
      @offers = JobOffer.all(:title.like => "%"+field+"%")
      @offers	
    end

    def default_search_location(param1,param2,field)
      @offers = JobOffer.new
      #offers = JobOffer.all(:location.like => "%"+field+"%")
      #job_offer.latitude,@job_offer.longitude
      @offers = JobOffer.all(:latitude.gte => param1-0.5, :latitude.lte => param1+0.5) + JobOffer.all(:longitude.gte => param2-0.5, :longitude.lte => param2+0.5)
      
      @offers	
    end

end