require 'digest/md5'
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

    def getGravatarImgAddressFromOfferer
    # return 'https://www.gravatar.com/avatar/' # + Digest::MD5.hexdigest(user.email) 
    # return 'https://www.gravatar.com/avatar/a5ef1ae46ae4e9aa7210a56a4b53a740'
    # return email
    return 'https://www.gravatar.com/avatar/'  + Digest::MD5.hexdigest(offerer_email) + '?s=30'
  end

end
