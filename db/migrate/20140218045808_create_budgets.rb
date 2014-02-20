class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.float :amount
      t.integer :user_id

      t.timestamps
    end
    add_index :budgets, [:user_id, :created_at]
  end
end
