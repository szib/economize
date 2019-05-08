class AddVisitorCounterToService < ActiveRecord::Migration[5.2]
  def change
    add_column :services, :visitor_count, :integer, default: 0
  end
end
