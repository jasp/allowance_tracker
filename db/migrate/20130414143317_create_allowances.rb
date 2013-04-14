class CreateAllowances < ActiveRecord::Migration
  def change
    create_table :allowances do |t|
      t.float :amount
      t.timestamp :started_at
      t.timestamp :ended_at
      t.belongs_to :account

      t.timestamps
    end
    add_index :allowances, :account_id
  end
end
