class AddCreatorToBatches < ActiveRecord::Migration[8.1]
  def change
    add_reference :batches, :creator, null: false, foreign_key: { to_table: :users }
  end
end
