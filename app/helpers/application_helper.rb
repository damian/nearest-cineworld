module ApplicationHelper

  def page_title(title = nil)
    base = 'Finding cineworld cinemas and cineworld film times has never been easier'
    title = title.blank? ? "Cineworld times | #{base}" : "#{title} | #{base}"
    content_for(:title, title)
  end

end
