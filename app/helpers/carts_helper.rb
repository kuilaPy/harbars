module CartsHelper
  def background_color check
    check ? "bg-green-200" : "bg-blue-100"
  end

  def get_container_color check
    check ? "bg-green-200 ring-green-500" : "ring-blue-100 bg-blue-100"
  end

  def text_color check
    check ? "text-green-500" : "text-blue-500"
  end
end
