module TasksHelper
  def task_priority_colour(priority)
    case priority
    when "emergency"
      content_tag(:span, "Emergency", class: "leading-5 inline-flex font-bold px-2 rounded-full bg-red-700 text-gray-200")
    when "high"
      content_tag(:span, "High", class: "leading-5 inline-flex font-bold px-2 rounded-full bg-red-500 text-gray-200")
    when "medium"
      content_tag(:span, "medium", class: "leading-5 inline-flex font-bold px-2 rounded-full bg-orange-500 text-gray-200")
    when "low"
      content_tag(:span, "low", class: "leading-5 inline-flex font-bold px-2 rounded-full bg-orange-600 text-gray-200")
    when "endeavour"
      content_tag(:span, "endeavour", class: "leading-5 inline-flex font-bold px-2 rounded-full bg-gray-600 text-gray-200")
    end
  end
end
