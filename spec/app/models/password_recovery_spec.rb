require 'spec_helper'

describe PasswordRecovery do

	describe 'model' do

		it { should respond_to( :user_email ) }

	end

	describe 'create_for' do

	  it 'should set user_email' do
	  	email = 'contact@test.com'
	  	pr = PasswordRecovery.create_for(email)
	  	pr.user_email.should eq email
	  end

	end

end	