require "administrate/base_dashboard"

class PracticeScheduleDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    practice_date: DateTimeField,
    practice_time: TimeSelectField,
    fp_count: NumberField,
    gk_count: NumberField,
    place: Field::String,
    remarks: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :practice_date,
    :practice_time,
    :fp_count,
    :gk_count,
    :place,
    :remarks,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :practice_date,
    :practice_time,
    :fp_count,
    :gk_count,
    :place,
    :remarks,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :practice_date,
    :practice_time,
    :fp_count,
    :gk_count,
    :place,
    :remarks,
  ].freeze

  # Overwrite this method to customize how practice schedules are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(practice_schedule)
    "PracticeSchedule ID:#{practice_schedule.id}"
  end
end
