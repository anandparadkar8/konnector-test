class CreateEnrollmentRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :enrollment_requests do |t|
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.references :batch, null: false, foreign_key: true
      t.string :status, default: "pending"

      t.timestamps
    end

    add_index :enrollment_requests, [:student_id, :batch_id], unique: true
  end
end
