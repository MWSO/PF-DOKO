class ChangeCloumnsNotnullAddTagRelations < ActiveRecord::Migration[6.1]
  def change
    change_column_null :tag_relations, :post_id, false
    change_column_null :tag_relations, :tag_id, false
  end
  add_index :tag_relations, [:post_id, :tag_id], unique: true
end
