require 'spec_helper'

describe User do

	describe 'model' do

		subject { @user = User.new }

		it { should respond_to( :id) }
		it { should respond_to( :name ) }
		it { should respond_to( :crypted_password) }
		it { should respond_to( :email ) }
        it { should respond_to( :company ) }
		it { should respond_to( :job_offers ) }
		it { should respond_to( :code ) }

	end

	describe 'valid?' do

	  let(:user) { User.new }

	  it 'should be false when name is blank' do
	  	user.email = 'john.doe@someplace.com'
	  	user.password = 'a_secure_passWord!'
	  	expect(user.valid?).to eq false
	  end


	  it 'should be false when email is not valid' do
	  	user.name = 'John Doe'
	  	user.email = 'john'
	  	user.password = 'a_secure_passWord!'
	  	expect(user.valid?).to eq false
	  end

	  it 'should be false when password is blank' do
	  	user.name = 'John Doe'
	  	user.email = 'john.doe@someplace.com'
	  	expect(user.valid?).to eq false
	  end
 	
	  it 'should be true when company is blank' do
	  	user.name = 'John Doe'
	  	user.email = 'john.doe@someplace.com'
		user.password = 'a_secure_passWord!'
	  	expect(user.valid?).to eq true
	  end

	  it 'should be true when all field are valid' do
	  	user.name = 'John Doe'
	  	user.email = 'john.doe@someplace.com'
	  	user.password = 'a_secure_passWord!'
	  	expect(user.valid?).to eq true
	  end

	end

	describe 'authenticate' do

		before do
			@password = 'password'
		 	@user = User.new
		 	@user.email = 'ggab3000@yahoo.com'
		 	@user.password = @password
		end

		it 'should return nil when password do not match' do
			email = @user.email
			password = 'wrong_password'
			User.should_receive(:find_by_email).with(email).and_return(@user)
			User.authenticate(email, password).should be_nil
		end

		it 'should return nil when email do not match' do
			email = 'wrong@email.com'
			User.should_receive(:find_by_email).with(email).and_return(nil)
			User.authenticate(email, @password).should be_nil
		end

		it 'should return the user when email and password match' do
			email = @user.email
			User.should_receive(:find_by_email).with(email).and_return(@user)
			User.authenticate(email, @password).should eq @user
		end

		it 'deberia obtener img completo' do

		    esperado = 'https://www.gravatar.com/avatar/4df81e61d9b28e299e51369e3e97368c?s=30'
		    # esperado = 'https://www.gravatar.com/avatar/a5ef1ae46ae4e9aa7210a56a4b53a740' 
		    #esperado = 'nicopaez@gmail.com'
		    expect(@user.getGravatarImgAddress).to eq(esperado)
		end

		it 'deberia obtener weak password 123' do
		    expect(@user.verify_password_is_strong('123')).to eq false
		end

		it 'deberia obtener strong password largo' do
		    expect(@user.verify_password_is_strong('12sdf!33ddFFe+++')).to eq true
		end

		it 'deberia obtener strong password guatemalA1' do
		    expect(@user.verify_password_is_strong('guatemalA1')).to eq true
		end

		it 'deberia obtener strong password GuatemA12' do
		    expect(@user.verify_password_is_strong('GuatemA12')).to eq true
		end

		it 'deberia obtener weak password guatemal' do
		    expect(@user.verify_password_is_strong('guatemal')).to eq false
		end

	end

end

