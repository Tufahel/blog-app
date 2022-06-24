class AddRoleToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :users, :string, default: 'user'
    add_column :users, :role, :string, default: 'user'
  end
end
