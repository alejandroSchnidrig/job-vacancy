class JobApplication

	attr_accessor :applicant_email
        attr_accessor :offerer_email
	attr_accessor :job_offer
        attr_accessor :link_cv

	def self.create_for(email, link, offer)
		app = JobApplication.new
		app.applicant_email = email
		app.link_cv = link
		app.job_offer = offer
		app
	end

	def process_to_applicant
      JobVacancy::App.deliver(:notification, :contact_info_email, self)
    end

    def process_to_offerer
      JobVacancy::App.deliver(:notification, :offerer_info_email, self)
    end

    def valid_email?(email)
      email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
      (email =~ email_regex)
    end	

    def valid_cv?(link)
      link.start_with?("http://") || link.start_with?("https://")
    end 

end
