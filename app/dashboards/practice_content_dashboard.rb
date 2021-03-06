require "administrate/base_dashboard"

class PracticeContentDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    category: BelongsToField,
    id: Field::Number,
    practice_name: Field::String,
    head_count: Field::String,
    estimated_time: Field::String,
    concept: Field::Text,
    rule: Field::Text,
    remarks: Field::Text,
    strength: RangeField,
    url: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :category,
    :practice_name,
    :head_count,
    :estimated_time,
    :concept,
    :strength,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :category,
    :practice_name,
    :head_count,
    :estimated_time,
    :concept,
    :rule,
    :remarks,
    :strength,
    :url,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :category,
    :practice_name,
    :head_count,
    :estimated_time,
    :concept,
    :rule,
    :remarks,
    :strength,
    :url,
  ].freeze

  # Overwrite this method to customize how practice contents are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(practice_content)
    "PracticeContent ID:#{practice_content.id}"
  end
end
