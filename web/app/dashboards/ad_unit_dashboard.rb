require "administrate/base_dashboard"

class AdUnitDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    cpi: Field::Number.with_options(decimals: 2),
    url: Field::String,
    image_url: Field::String,
    media_url: Field::String,
    campaign_id: Field::Number,
    name: Field::String,
    is_active: Field::Boolean,
    total_impressions: Field::Number,
    total_conversions: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    cpi
    url
    image_url
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    cpi
    url
    image_url
    media_url
    campaign_id
    name
    is_active
    total_impressions
    total_conversions
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    cpi
    url
    image_url
    media_url
    campaign_id
    name
    is_active
    total_impressions
    total_conversions
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how ad units are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(ad_unit)
  #   "AdUnit ##{ad_unit.id}"
  # end
end
