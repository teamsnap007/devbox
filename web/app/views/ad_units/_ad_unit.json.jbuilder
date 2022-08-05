json.extract! ad_unit, :id, :cpi, :url, :image_url, :media_url, :campaign_id, :name, :is_active, :total_impressions, :total_conversions, :created_at, :updated_at
json.url ad_unit_url(ad_unit, format: :json)
