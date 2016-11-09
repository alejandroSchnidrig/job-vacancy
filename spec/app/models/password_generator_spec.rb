require 'spec_helper'

describe PasswordGenerator do

	describe 'model' do

		it { should respond_to( :user_email ) }
		it { should respond_to( :new_password ) }

	end

	describe 'create_for' do

	  it 'should set user_email' do
	  	email = 'contact@test.com'
	  	password = 'asd833123'
	  	pg = PasswordGenerator.create_for(email, password)
	  	pg.user_email.should eq email
	  end

	  it 'should set user password' do
	  	email = 'contact@test.com'
	  	password = 'asd833123'
	  	pg = PasswordGenerator.create_for(email, password)
	  	pg.new_password.should eq password
	  end

	end

end	