class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :account_id
      t.integer :service_id
      t.timestamps
    end
  end
end
