class AddDiscardedAtToWorkers < ActiveRecord::Migration[7.0]
  def change
    add_column :workers, :discarded_at, :datetime
    add_index :workers, :discarded_at
  end
end
