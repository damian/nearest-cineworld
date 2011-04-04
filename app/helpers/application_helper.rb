module ApplicationHelper

  def page_title(title = nil)
    base = 'Finding cineworld cinemas and cineworld show times has never been easier'
    title = title.blank? ? "Cineworld times | #{base}" : "#{title} | #{base}"
    content_for(:title, title)
  end

  def body_classes
    ["#{params[:controller]}-controller", "#{params[:action]}-action"].join(' ')
  end

  def body_ids
    ["#{params[:controller]}-controller", "#{params[:action]}-action"].join('-')
  end

end
