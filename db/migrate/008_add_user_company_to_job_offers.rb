migration 3, :add_user_company_to_job_offers do
  up do
    modify_table :job_offers do
      add_column :user_company, String
    end
  end

  down do
    modify_table :job_offers do
      drop_column :user_company
    end
  end
end
