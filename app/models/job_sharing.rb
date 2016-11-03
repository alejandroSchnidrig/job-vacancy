class JobSharing

	attr_accessor :contact_email
	attr_accessor :comments
	attr_accessor :job_offer

	def self.create_for(email, comments, offer)
		app = JobSharing.new
		app.contact_email = email
		app.comments = comments
		app.job_offer = offer
		app
	end

	def process
    JobVacancy::App.deliver(:notification, :sharing_email, self)
    end

    def valid_email?(email)
      email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
      (email =~ email_regex)
    end	

end