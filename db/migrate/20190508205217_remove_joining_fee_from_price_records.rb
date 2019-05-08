class RemoveJoiningFeeFromPriceRecords < ActiveRecord::Migration[5.2]
  def change
    remove_column :price_records, :joining_fee
  end
end
