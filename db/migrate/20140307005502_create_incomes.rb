class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.string :tag
      t.float :amount
      t.integer :budget_id

      t.timestamps
    end
    add_index :incomes, [:budget_id, :created_at]
  end
end
