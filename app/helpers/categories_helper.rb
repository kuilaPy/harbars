module CategoriesHelper
  def get_parents(category)
    parents = []
    parent = category.parent_category
    while parent.present?
      parents << parent.name
      parent = parent.parent_category
    end
    parents.join(" < ")
  end
end
