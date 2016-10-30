require 'spec_helper'

describe JobSharing do

	describe 'model' do

		subject { @job_offer = JobSharing.new }

		it { should respond_to( :contact_email ) }
		it { should respond_to( :comments ) }
		it { should respond_to( :job_offer) }

	end

	describe 'create_for' do

	  it 'should set contact_email' do
	  	email = 'contact@test.com'
	  	comments = "some words"
	  	js = JobSharing.create_for(email, comments, JobOffer.new)
	  	js.contact_email.should eq email
	  end

	  it 'should set job_offer' do
	  	offer = JobOffer.new
	  	js = JobSharing.create_for('contact@test.com', 'some words', offer)
	  	js.job_offer.should eq offer
	  end

	end


	describe 'process' do

	  let(:job_sharing) { JobSharing.new }

	  it 'should deliver sharing offer info notification' do
	  	js = JobSharing.create_for('contact@test.com','some words', JobOffer.new)
	  	JobVacancy::App.should_receive(:deliver).with(:notification, :sharing_email, js)
	  	js.process
	  end

	end

	describe 'email_validation' do

	  it 'should be an invalid email missing @' do
	  	email = 'applicanttest.com'
	  	comments = 'hola'
	  	js = JobSharing.create_for(email, comments, JobOffer.new)
	  	expect(js.valid_email?(email)).to be false
	  end

	  it 'should be an valid email' do
	  	email = 'applicant@test.com'
	  	comments = 'hola'
	  	js = JobSharing.create_for(email, comments, JobOffer.new)
	  	expect(js.valid_email?(email)).to be true
	  end

	  it 'should be an invalid email missing .com' do
	  	email = 'applican@test'
	  	comments = 'hola'
	  	js = JobSharing.create_for(email, comments, JobOffer.new)
	  	expect(js.valid_email?(email)).to be false
	  end

	  it 'should be an invalid email missing @ and .com' do
	  	email = 'nnn'
	  	comments = 'hola'
	  	js = JobSharing.create_for(email, comments, JobOffer.new)
	  	expect(js.valid_email?(email)).to be false
	  end

    end 

end	