class CodeGenerator

	attr_accessor :user_email
	attr_accessor :code

	def self.create_for(email, code)
	  app = CodeGenerator.new
	  app.user_email = email
	  app.code = code
	  app
	end

	def process
      JobVacancy::App.deliver(:notification, :code_generator_email, self)
    end

    def valid_email?(email)
      email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
      (email =~ email_regex)
    end	


end