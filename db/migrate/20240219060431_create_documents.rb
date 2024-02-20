class CreateDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :documents do |t|
      t.string :name
      t.integer :extension_type, default: 0, null: false
      t.references :patient, null: false, foreign_key: true
      t.jsonb :data, default: {}, null: false

      t.timestamps
    end
  end
end
