class AddHasConnectionToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :has_connection, :boolean, :default => false
  end
end
