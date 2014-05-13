Sequel.migration do
  change do

    create_table :hits do
      primary_key :id
      String :url, null: false, size:4096
      String :referrer, size:4096
      Time :created_at
      String :hash, null: false

    end

  end
end
