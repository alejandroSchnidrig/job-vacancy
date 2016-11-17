migration 8, :add_user_company_to_users do
  up do
    modify_table :users do
      add_column :user_company, String
    end
  end

  down do
    modify_table :users do
      drop_column :user_company
    end
  end
end
