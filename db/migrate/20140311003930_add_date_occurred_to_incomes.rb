class AddDateOccurredToIncomes < ActiveRecord::Migration
  def change
    add_column :incomes, :date_occurred, :date
  end
end
