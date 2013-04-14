class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :description
      t.float :amount
      t.timestamp :paid_at
      t.belongs_to :account

      t.timestamps
    end
    add_index :expenses, :account_id
  end
end
