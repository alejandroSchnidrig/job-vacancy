require 'spec_helper'

describe JobApplication do

	describe 'model' do

		subject { @job_offer = JobApplication.new }

		it { should respond_to( :applicant_email ) }
		it { should respond_to( :job_offer) }
		it { should respond_to( :link_cv) }

	end


	describe 'create_for' do

	  it 'should set applicant_email' do
	  	email = 'applicant@test.com'
                link = 'the_cv'
	  	ja = JobApplication.create_for(email, link, JobOffer.new)
	  	ja.applicant_email.should eq email
                ja.link_cv.should eq link
	  end

	  it 'should set job_offer' do
	  	offer = JobOffer.new
	  	ja = JobApplication.create_for('applicant@test.com', 'the _cv', offer)
	  	ja.job_offer.should eq offer
	  end

	end


	describe 'process_to_applicant' do

	  let(:job_application) { JobApplication.new }

	  it 'should deliver contact info notification' do
	  	ja = JobApplication.create_for('applicant@test.com', 'the_cv', JobOffer.new)
	  	JobVacancy::App.should_receive(:deliver).with(:notification, :contact_info_email, ja)
	  	ja.process_to_applicant
	  end

        end

       describe 'process_to_offerer' do

	  let(:job_application) { JobApplication.new }

	  it 'should deliver offerer info notification' do
	  	ja = JobApplication.create_for('applicant@test.com', 'the_cv', JobOffer.new)
	  	JobVacancy::App.should_receive(:deliver).with(:notification, :offerer_info_email, ja)
	  	ja.process_to_offerer
	  end

        end


	describe 'valid_cv?' do

		  it 'not valid cv GuatemA12' do
	  	email = 'applicant@test.com'
                link = 'GuatemA12'
	  	ja = JobApplication.create_for(email, link, JobOffer.new)
                  expect(ja.valid_cv?(link)).to eq false
	  end

	  	  it 'valid cv https' do
	  	email = 'applicant@test.com'
                link = 'https://www.facebook.com/photo.php?fbid=10210983398364814&set=gm.10154330125603101&type=3&theater'
	  	ja = JobApplication.create_for(email, link, JobOffer.new)
                  expect(ja.valid_cv?(link)).to eq true
	  end


	 #  let(:job_offer) { 
	 #  	JobOffer.new.cv 
	 #  	 }

		# it 'not valid cv GuatemA12' do
		#     expect(@job_application.valid_cv?('GuatemA12').to eq false
		# end

		# it 'valid cv https' do
		#     expect(@job_application.valid_cv?('https://www.facebook.com/photo.php?fbid=10210983398364814&set=gm.10154330125603101&type=3&theater').to eq true
		# end
	end
	
        
end
