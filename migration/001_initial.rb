Sequel.migration do
  change do
    create_table(:people) do
      primary_key :id
      String :name, :size=>1024
    end
  end
end
