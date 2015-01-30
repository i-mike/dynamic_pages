class Common::PagesController < CommonController

  # GET /pages
  def index
    @page = Page.roots.enabled.order(priority: :desc).take
    if @page
      redirect_to @page
    else
      render :index
    end
  end

  # GET /pages/1
  def show
    @page = Page.with_localized_content.enabled.find_by_slug!(params[:id])

    @pages = []
    if @page.root?
      @pages << Page.with_localized_content.enabled.find_all_by_generation(@page.depth)
      @pages << Page.with_localized_content.where(parent_id: @page.id).enabled.find_all_by_generation(@page.depth + 1)
    else
      @pages << Page.with_localized_content.enabled.find_all_by_generation(@page.parent.depth)
      @pages << @page.parent.children.with_localized_content.enabled
    end
    @pages << Page.with_localized_content.enabled.find_all_by_generation(@page.depth)

    @active_pages = @page.self_and_ancestors
  end

end
