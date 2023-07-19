module ApplicationHelper
  include Pagy::Frontend

  def convert_datetime(time)
    time.strftime("%a %e %b %H:%M")
  end
end
