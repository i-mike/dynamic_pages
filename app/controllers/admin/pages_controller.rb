class Admin::PagesController < AdminController
  # include TheSortableTreeController::Rebuild

  before_action :set_page, only: [:show, :edit, :update, :destroy]

  # GET /pages
  # GET /pages.json
  def index

    @pages =  if params[:tree] #and request.format.json?
                Page.with_localized_content.hash_tree
              else
                Page.none
              end

    respond_to do |format|
      format.html do
        render :index
      end

      format.json do
          render :index, status: :ok
      end
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    @page_contents = @page.page_contents.select("id, language_id")
  end

  # GET /pages/new
  def new
    @page = if params[:parent_id]
              Page.find(params[:parent_id]).children.build
            else
              Page.new
            end
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to admin_page_path(@page), notice: 'Page was successfully created.' }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to admin_page_path(@page), notice: 'Page was successfully updated.' }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to admin_pages_path, notice: 'Page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.where(slug: params[:id]).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:slug, :priority, :enabled, :parent_id)
    end
end
