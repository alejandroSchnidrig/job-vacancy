migration 10, :add_gpscords_to_offers do
  up do
    modify_table :job_offers do
      add_column :latitude, DataMapper::Property::Float 
      add_column :longitude , DataMapper::Property::Float
    end
  end

 
end
