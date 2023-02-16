class ChangeCloumnsNotnullAddUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :name, :string,  null: false
    change_column :users, :name, :string,  null: false
    change_column :users, :name, :string,  null: false
    change_column_default(:users, :is_deleted, from: nil, to: false)

  end
end
