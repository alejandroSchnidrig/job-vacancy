require 'spec_helper'

describe PasswordGenerator do

	describe 'model' do

		it { should respond_to( :user_email ) }

	end

	describe 'create_for' do

	  it 'should set user_email' do
	  	email = 'contact@test.com'
	  	pg = PasswordGenerator.create_for(email)
	  	pg.user_email.should eq email
	  end

	end

end	