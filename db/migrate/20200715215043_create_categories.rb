class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.float :min
      t.float :max
      t.float :percentage

      t.timestamps
    end
  end
end
