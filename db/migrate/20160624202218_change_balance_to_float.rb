class ChangeBalanceToFloat < ActiveRecord::Migration
  def change
  	change_column :lenders, :balance, 'float USING CAST(balance AS float)'
  end
end
