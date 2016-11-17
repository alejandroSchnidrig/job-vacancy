migration 9, :add_user_code_to_users do
  up do
    modify_table :users do
      add_column :code, String
    end
  end

  down do
    modify_table :users do
      drop_column :code
    end
  end
end