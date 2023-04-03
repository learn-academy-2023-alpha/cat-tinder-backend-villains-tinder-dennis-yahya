class CreateVillains < ActiveRecord::Migration[7.0]
  def change
    create_table :villains do |t|
      t.string :name
      t.integer :age
      t.text :enjoy
      t.text :img

      t.timestamps
    end
  end
end
