require "administrate/field/base"

class RangeField < Administrate::Field::Base
  def to_s
    data
  end
end
