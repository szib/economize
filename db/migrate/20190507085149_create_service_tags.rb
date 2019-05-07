class CreateServiceTags < ActiveRecord::Migration[5.2]
  def change
    create_table :service_tags do |t|
      t.integer :service_id
      t.integer :tag_id
      t.timestamps
    end
  end
end
