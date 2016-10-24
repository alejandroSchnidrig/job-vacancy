
user = User.create(:email => 'nicopaez@gmail.com',
									 :name => 'Offerer', 
									 :password => "n") unless User.all.count > 0
