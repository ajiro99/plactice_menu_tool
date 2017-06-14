require "administrate/field/base"

class DateTimeField < Administrate::Field::Base
  def to_s
    data
  end

  def to_datetime
    data.to_datetime.strftime('%Y-%m-%d(%a)　%H:%M')
  end
end
