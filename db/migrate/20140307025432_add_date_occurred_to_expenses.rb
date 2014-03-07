class AddDateOccurredToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :date_occurred, :date
  end
end
