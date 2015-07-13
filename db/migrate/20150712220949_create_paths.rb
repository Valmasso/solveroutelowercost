class CreatePaths < ActiveRecord::Migration
  def change
    create_table :paths do |t|
      t.string :from
      t.string :to
      t.decimal :distance, precision: 10, scale: 2
      t.references :map, index: true

      t.timestamps
    end
  end
end
