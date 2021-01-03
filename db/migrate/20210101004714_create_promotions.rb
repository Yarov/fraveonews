class CreatePromotions < ActiveRecord::Migration[6.0]
  def change
    create_table :promotions do |t|
      t.string :title
      t.text :description
      t.string :promocode
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
