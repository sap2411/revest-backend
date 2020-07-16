class AddTagsToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :tags, :string
  end
end
