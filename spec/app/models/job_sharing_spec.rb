require 'spec_helper'

describe JobSharing do

	describe 'model' do

		subject { @job_offer = JobSharing.new }

		it { should respond_to( :contact_email ) }
		it { should respond_to( :comments ) }
		it { should respond_to( :job_offer) }

	end

end	