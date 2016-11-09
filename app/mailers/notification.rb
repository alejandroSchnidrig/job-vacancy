##
# Mailer methods can be defined using the simple format:
#
# email :registration_email do |name, user|
#   from 'admin@site.com'
#   to   user.email
#   subject 'Welcome to the site!'
#   locals  :name => name
#   content_type 'text/html'       # optional, defaults to plain/text
#   via     :sendmail              # optional, to smtp if defined, otherwise sendmail
#   render  'registration_email'
# end
#
# You can set the default delivery settings from your app through:
#
#   set :delivery_method, :smtp => {
#     :address         => 'smtp.yourserver.com',
#     :port            => '25',
#     :user_name       => 'user',
#     :password        => 'pass',
#     :authentication  => :plain, # :plain, :login, :cram_md5, no auth by default
#     :domain          => "localhost.localdomain" # the HELO domain provided by the client to the server
#   }
#
# or sendmail (default):
#
#   set :delivery_method, :sendmail
#
# or for tests:
#
#   set :delivery_method, :test
#
# or storing emails locally:
#
#   set :delivery_method, :file => {
#     :location => "#{Padrino.root}/tmp/emails",
#   }
#
# and then all delivered mail will use these settings unless otherwise specified.
#

JobVacancy::App.mailer :notification do

  email :contact_info_email do | job_application |
    from 'n2.jobvacancy@gmail.com'
    to job_application.applicant_email
    subject 'Job Application: Contact information'
    locals :job_offer => job_application.job_offer
    content_type :html
    render 'notification/contant_info_email'
  end

  email :offerer_info_email do | job_application |
    from 'n2.jobvacancy@gmail.com'
    to job_application.offerer_email
    subject 'Job Application: Applicant information'
    locals :job_offer => job_application.job_offer ,
           :offerer =>  job_application.getGravatarImgAddressFromOfferer
    content_type :html
    render 'notification/offerer_info_email'
  end

  email :sharing_email do | job_sharing |
    from 'n2.jobvacancy@gmail.com'
    to job_sharing.contact_email
    subject 'Job Sharing: Offer information'
    locals :job_offer => job_sharing.job_offer
    content_type :html
    render 'notification/sharing_email'
  end

end
