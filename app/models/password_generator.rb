class PasswordGenerator

	attr_accessor :user_email

	def self.create_for(email)
		app = PasswordGenerator.new
		app.user_email = email
		app
	end

	def process
    JobVacancy::App.deliver(:notification, :password_generator_email, self)
    end

    def valid_email?(email)
      email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
      (email =~ email_regex)
    end	

end