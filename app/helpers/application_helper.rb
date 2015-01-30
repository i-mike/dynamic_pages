module ApplicationHelper
  def admin?
    controller.class.name.split("::").first == "Admin"
  end

  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end

  def title(page_title)
    content_for :title, "asdCode - #{page_title.to_s}"
  end
end
