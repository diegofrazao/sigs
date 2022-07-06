class AddServiceIdToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :service_id, :integer
  end
end
