class CreateTagRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_relations do |t|
      t.integer :tag_id
      t.integer :post_id

      t.timestamps
    end
  end
end
