migration 9, :create_users_with_company do
  up do
    create_table :users do
      column :id, Integer, :serial => true
      column :name, DataMapper::Property::String, :length => 255
      column :crypted_password, DataMapper::Property::String, :length => 255
      column :email, DataMapper::Property::String, :length => 255
      column :company, DataMapper::Property::String, :length => 255
    end
  end

  down do
    drop_table :users
  end
end
