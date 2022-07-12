class CreateOrdersServicesJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :orders, :services do |t|
      t.index [:order_id, :service_id]
      t.index [:service_id, :order_id]
    end
  end
end
