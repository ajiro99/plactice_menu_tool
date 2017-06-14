require "administrate/field/base"

class TimeSelectField < Administrate::Field::Base
  def to_s
    data.to_s.split(" ").second[1, 4]
  end
end
