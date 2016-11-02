migration 11, :add_cv_link_to_job_offers do
  up do
      modify_table :job_offers do
      add_column :link_cv, String
    end  
  end

  down do
      modify_table :job_offers do
      drop_column :link_cv
    end
  end
end
