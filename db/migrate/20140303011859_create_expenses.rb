class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.integer :budget_id
      t.string :tag
      t.float :amount

      t.timestamps
    end
    add_index :expenses, [:budget_id, :created_at]
  end
end
