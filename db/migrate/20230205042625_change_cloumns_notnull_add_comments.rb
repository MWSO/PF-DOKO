class ChangeCloumnsNotnullAddComments < ActiveRecord::Migration[6.1]
  def change
    change_column_null :comments, :user_id, false
    change_column_null :comments, :post_id, false
    change_column_null :comments, :comment, false
  end
end
