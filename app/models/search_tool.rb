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

    def default_search(field)
      @offers = JobOffer.new
      @offers = JobOffer.all(:title.like => "%"+field+"%")
      @offers	
    end

end