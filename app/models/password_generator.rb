class PasswordGenerator

	attr_accessor :user_email
	attr_accessor :new_password

	def self.create_for(email, password)
		app = PasswordGenerator.new
		app.user_email = email
		app.new_password = password
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