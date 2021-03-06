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
    if (param1.nil? or param2.nil? or param1 == 0.0 or param2 == 0.0)
      @offers = JobOffer.all(:location.like => "%"+field+"%")
    else
      @offers = (JobOffer.all(:latitude.gte => param1-0.5, :latitude.lte => param1+0.5) &  JobOffer.all(:longitude.gte => param2-0.5, :longitude.lte => param2+0.5)) + JobOffer.all(:location.like => "%"+field+"%")
    end
    @offers	
  end

end