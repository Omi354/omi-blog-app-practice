class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :nickname
      t.text :introduction
      t.integer :gender
      t.date :birth_day
      t.boolean :subscribed
      t.timestamps
    end
  end
end
