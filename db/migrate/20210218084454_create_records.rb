class CreateRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :records do |t|
      t.date :date
      t.text :memo
      t.integer :subject_id
      t.integer :price
      t.text :detail
      t.integer :user_id

      t.timestamps
    end
  end
end
