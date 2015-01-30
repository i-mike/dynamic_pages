class Common::PagePresenter < BasePresenter
  presents :page

  def first_level_pages_selector(pages, active_pages)
    %Q{
      <ul class='nav navbar-nav'>
        #{generate_lis(pages, active_pages)}
      </ul>
    }.html_safe
  end

  def second_level_pages_selector(pages, active_pages)
    %Q{
      <ul class='nav nav-pills'>
        #{generate_lis(pages, active_pages)}
      </ul>
    }.html_safe
  end

  def generate_lis(pages, active_pages)
    pages.inject("") do |result, page|
      result + "<li #{'class="active"' if active_pages.include?(page)}>#{link_to(page.localized_title, page)}</li>"
    end
  end
end