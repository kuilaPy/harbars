module ApplicationHelper
  def status_tag(status)
    case status
    when "initiate"
      content_tag(:span, status.titleize, class: "bg-blue-100 text-blue-500 text-base font-normal me-2 px-3 py-1 rounded-lg")
    when "processed"
      content_tag(:span, status.titleize, class: "bg-yellow-100 text-yellow-500 text-base font-normal me-2 px-3 py-1 rounded-lg")
    when "shipped"
      content_tag(:span, status.titleize, class: "bg-purple-100 text-purple-500 text-base font-normal me-2 px-3 py-1 rounded-lg")
    when "delivered"
      content_tag(:span, status.titleize, class: "bg-green-100 text-green-500 text-base font-normal me-2 px-3 py-1 rounded-lg")
    when "cancelled"
      content_tag(:span, status.titleize, class: "bg-red-100 text-red-500 text-base font-normal me-2 px-3 py-1 rounded-lg")
    else
      content_tag(:span, status.titleize, class: "bg-gray-100 text-gray-500 text-base font-normal me-2 px-3 py-1 rounded-lg")
    end
  end

  def repliyer_type(reply)
    if reply.user.present?
      "Verified Buyer"
    elsif reply.admin_user.present?
      "Admin"
    else
      "Orthers"
    end
  end
end
