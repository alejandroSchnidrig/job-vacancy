require 'spec_helper'

describe CodeGenerator do

	describe 'model' do

		it { should respond_to( :user_email ) }
		it { should respond_to( :code) }

	end

	describe 'create_for' do

	  it 'should set user_email' do
	  	email = 'contact@test.com'
	  	code = 'asd833123'
	  	cg = CodeGenerator.create_for(email, code)
	  	cg.user_email.should eq email
	  end

	  it 'should set user password' do
	  	email = 'contact@test.com'
	  	code = 'asd833123'
	  	cg = CodeGenerator.create_for(email, code)
	  	cg.code.should eq code
	  end

	end

end	