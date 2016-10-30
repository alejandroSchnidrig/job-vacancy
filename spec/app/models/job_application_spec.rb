require 'spec_helper'

describe JobApplication do

	describe 'model' do

		subject { @job_offer = JobApplication.new }

		it { should respond_to( :applicant_email ) }
		it { should respond_to( :job_offer) }

	end


	describe 'create_for' do

	  it 'should set applicant_email' do
	  	email = 'applicant@test.com'
	  	ja = JobApplication.create_for(email, JobOffer.new)
	  	ja.applicant_email.should eq email
	  end

	  it 'should set job_offer' do
	  	offer = JobOffer.new
	  	ja = JobApplication.create_for('applicant@test.com', offer)
	  	ja.job_offer.should eq offer
	  end

	end


	describe 'process' do

	  let(:job_application) { JobApplication.new }

	  it 'should deliver contact info notification' do
	  	ja = JobApplication.create_for('applicant@test.com', JobOffer.new)
	  	JobVacancy::App.should_receive(:deliver).with(:notification, :contact_info_email, ja)
	  	ja.process
	  end

	end

	describe 'email_validation' do

	  it 'should be an invalid email missing @' do
	  	email = 'applicanttest.com'
	  	ja = JobApplication.create_for(email, JobOffer.new)
	  	expect(ja.valid_email?(email)).to be false
	  end

	  it 'should be an valid email' do
	  	email = 'applicant@test.com'
	  	ja = JobApplication.create_for(email, JobOffer.new)
	  	expect(ja.valid_email?(email)).to be true
	  end

	  it 'should be an invalid email missing .com' do
	  	email = 'applican@test'
	  	ja = JobApplication.create_for(email, JobOffer.new)
	  	expect(ja.valid_email?(email)).to be false
	  end

	  it 'should be an invalid email missing @ and .com' do
	  	email = 'nnn'
	  	ja = JobApplication.create_for(email, JobOffer.new)
	  	expect(ja.valid_email?(email)).to be false
	  end

    end 

end
