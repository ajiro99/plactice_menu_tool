require "administrate/field/base"

class NumberField < Administrate::Field::Base
  def to_s
    data
  end
end
