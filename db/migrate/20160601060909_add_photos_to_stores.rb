class AddPhotosToStores < ActiveRecord::Migration
  def change
    add_column :stores, :logo, :string
    add_column :stores, :background_image, :string
  end
end
