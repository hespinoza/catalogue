class AddVisitsCountToStores < ActiveRecord::Migration
  def change
    add_column :stores, :visits_count, :integer
  end
end
