class JobSharing

	attr_accessor :contact_email
	attr_accessor :comments
	attr_accessor :job_offer

	def self.create_for(email, comments, offer)
		app = JobApplication.new
		app.contact_email = email
		app.comments = comments
		app.job_offer = offer
		app
	end

	def process
    JobVacancy::App.deliver(:notification, :contact_info_email, self)
  end

end