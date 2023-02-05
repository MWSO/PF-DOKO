class ChangeCloumnsNotnullAddTagRelations < ActiveRecord::Migration[6.1]
  def change
    change_column_null :tag_relations, :post_id, false
    change_column_null :tag_relations, :tag_id, false
  end
end
