module ApplicationHelper
  def nav_link(text, path)
    content_tag(:li, class: (current_page?(path) ? 'active' : '')) do
      link_to text, path
    end
  end
end
