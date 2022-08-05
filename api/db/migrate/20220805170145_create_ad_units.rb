class CreateAdUnits < ActiveRecord::Migration[6.1]
  def change
    create_table :ad_units do |t|
      t.float :cpi
      t.string :url
      t.string :image_url
      t.string :media_url
      t.integer :campaign_id
      t.string :name
      t.boolean :is_active
      t.integer :total_impressions
      t.integer :total_conversions

      t.timestamps
    end
  end
end
