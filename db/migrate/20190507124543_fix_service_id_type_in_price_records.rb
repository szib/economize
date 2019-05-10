class FixServiceIdTypeInPriceRecords < ActiveRecord::Migration[5.2]
  def change
    change_column :price_records, :service_id, :integer
    # Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
