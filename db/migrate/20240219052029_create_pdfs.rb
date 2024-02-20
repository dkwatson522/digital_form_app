class CreatePdfs < ActiveRecord::Migration[6.1]
  def change
    create_table :pdfs do |t|
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
