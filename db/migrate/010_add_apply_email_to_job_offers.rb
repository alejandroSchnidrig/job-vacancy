migration 10, :add_apply_email_to_job_offers do
  up do
      modify_table :job_offers do
      add_column :apply_email, String
    end  
  end

  down do
      modify_table :job_offers do
      drop_column :apply_email
    end
  end
end
