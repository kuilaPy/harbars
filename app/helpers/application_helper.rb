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

  def star_rating(rating)
    full_stars = rating.floor
    empty_stars = 5 - full_stars

    full_star_svg = content_tag(:svg, class: 'h-5 w-5 fill-current text-yellow-500', xmlns: 'http://www.w3.org/2000/svg', viewBox: '0 0 20 20', fill: 'currentColor') do
      content_tag(:path, '', 'fill-rule': 'evenodd', d: 'M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.284 3.955a1 1 0 00.95.69h4.21c.969 0 1.372 1.24.588 1.81l-3.403 2.474a1 1 0 00-.364 1.118l1.284 3.955c.3.921-.755 1.688-1.54 1.118l-3.403-2.474a1 1 0 00-1.175 0l-3.403 2.474c-.784.57-1.838-.197-1.539-1.118l1.283-3.955a1 1 0 00-.364-1.118L2.23 8.382c-.783-.57-.38-1.81.588-1.81h4.21a1 1 0 00.95-.69l1.284-3.955z', 'clip-rule': 'evenodd')
    end

    empty_star_svg = content_tag(:svg, class: 'h-5 w-5 fill-current text-gray-300', xmlns: 'http://www.w3.org/2000/svg', viewBox: '0 0 20 20', fill: 'currentColor') do
      content_tag(:path, '', 'fill-rule': 'evenodd', d: 'M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.284 3.955a1 1 0 00.95.69h4.21c.969 0 1.372 1.24.588 1.81l-3.403 2.474a1 1 0 00-.364 1.118l1.284 3.955c.3.921-.755 1.688-1.54 1.118l-3.403-2.474a1 1 0 00-1.175 0l-3.403 2.474c-.784.57-1.838-.197-1.539-1.118l1.283-3.955a1 1 0 00-.364-1.118L2.23 8.382c-.783-.57-.38-1.81.588-1.81h4.21a1 1 0 00.95-.69l1.284-3.955z', 'clip-rule': 'evenodd')
    end

    (full_star_svg * full_stars + empty_star_svg * empty_stars).html_safe
  end
end
