class Admin::PageContentsController < AdminController

  def show
    load_page_content
  end

  def new
    build_page_content
    @page_content.page = Page.where(slug: params[:page_id]).first
  end

  def create
    build_page_content
    save_page_content or render :new
  end

  def edit
    load_page_content
  end

  def update
    load_page_content
    build_page_content
    save_page_content or render :edit
  end

  def destroy
  #   TODO: delete this
  end

  private

    def build_page_content
      @page_content ||= PageContent.new
      @page_content.attributes = page_content_params
      @page_content.page = Page.where(slug: params[:page_id]).first
    end

    def load_page_content
      @page_content = PageContent.find(params[:id])
    end

    def save_page_content
      if @page_content.save
        redirect_to admin_page_page_content_path(@page_content.page, @page_content)
      end
    end

    def page_content_params
      page_content_params = params[:page_content]
      page_content_params ? page_content_params.permit(:title, :body, :language_id) : {}
    end
end