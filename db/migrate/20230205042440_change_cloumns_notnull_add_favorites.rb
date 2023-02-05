class ChangeCloumnsNotnullAddFavorites < ActiveRecord::Migration[6.1]
  def change
    change_column_null :favorites, :user_id, false
    change_column_null :favorites, :post_id, false
  end
end
