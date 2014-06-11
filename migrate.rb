require 'active_record'

ActiveRecord::Base.establish_connection(YAML.load_file('mysql.yml'))

ActiveRecord::Base.connection.create_table :properties do |t|
  t.string :case_participants
  t.string :attorney
  t.string :address
  t.string :price
  t.integer :price_in_dollars
  t.decimal :latitude, {:precision=>10, :scale=>6}
  t.decimal :longitude, {:precision=>10, :scale=>6}
  t.datetime :created_at, null: true
  t.datetime :updated_at, null: true
end

ActiveRecord::Base.connection.change_column :properties, :latitude, :decimal, precision: 10, scale: 6
