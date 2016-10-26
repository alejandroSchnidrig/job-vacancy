migration 8, :add_comments_to_job_offers do
  up do
  	modify_table :job_offers do
      add_column :comments, String
    end  
  end

  down do
  	modify_table :job_offers do
      drop_column :comments
    end
  end
end
