class Admin::PagePresenter < BasePresenter
  presents :page

  def contents_links(contents)
    contents.map do |content|
      link_to content.language.slug, admin_page_page_content_path(page, content)
    end.join(" | ").html_safe
  end
end