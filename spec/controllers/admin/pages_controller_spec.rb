require 'rails_helper'

describe Admin::PagesController, :type => :controller do

  describe 'GET #show' do
    let(:page) { create(:page) }

    before :each do
      get :show, id: page, locale_or_role: :admin
    end

    it "assigns the requested page to @page" do
      get :show, id: page, locale_or_role: :admin
      expect(assigns(:page)).to eq page
    end

    it "renders the :show template" do
      get :show, id: page, locale_or_role: :admin
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    context "without parent" do
      before :each do
        get :new, locale_or_role: :admin
      end

      it "assigns a new Page to @page" do
        expect(assigns(:page)).to be_a_new(Page)
      end

      it "renders the :new template" do
        expect(response).to render_template :new
      end
    end

    context "with parent" do
      let (:parent_page) { create(:page) }

      before :each do
        get :new, parent_id: parent_page.id, locale_or_role: :admin
      end

      it "assigns a new Page to @page" do
        expect(assigns(:page)).to be_a_new(Page)
      end

      it "assigns a new Page to @page with specified parent" do
        expect(assigns(:page).parent).to eq parent_page
      end
    end
  end

  describe 'GET #edit' do
    let(:page) { create(:page) }

    before :each do
      get :edit, id: page, locale_or_role: :admin
    end

    it "assigns the requested page to @page" do
      expect(assigns(:page)).to eq page
    end

    it "renders the :edit template" do
      expect(response).to render_template :edit
    end
  end

  # TODO: add invalid attributes
  describe "POST #create" do
    context "without parent" do
      it "saves the new page in the database" do
        expect{
          post :create, page: attributes_for(:page), locale_or_role: :admin
        }.to change(Page, :count).by(1)
      end

      it "redirects to page#show" do
        post :create, page: attributes_for(:page), locale_or_role: :admin
        expect(response).to redirect_to page_path(assigns[:page])
      end
    end

    context "with parent" do
      let! (:parent_page) { create(:page) }

      it "saves the new page in the database" do
        expect{
          post :create, page: attributes_for(:page), parent_id: parent_page.id, locale_or_role: :admin
        }.to change(Page, :count).by(1)
      end

      it "saves the new page in the database with specified parent" do
        post :create, page: attributes_for(:page, parent_id: parent_page.id), locale_or_role: :admin
        expect(assigns(:page).parent).to eq parent_page
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      parent_page = create(:page)
      # page_2 = create(:page)
      @page = create(:page,
                     :slug => 'slug',
                     :priority => 1,
                     :enabled => true,
                     :parent_id => parent_page.id
      )
    end

    it "locates the requested @page" do
      patch :update, id: @page, :page => attributes_for(:page), :locale_or_role => :admin
      expect(assigns(:page)).to eq @page
    end

    it "changes the page's attributes" do
      patch :update, id: @page,
            page: attributes_for(:page,
                                 :slug => 'new-slug',
                                 :priority => 2,
                                 :enabled => false,
                                 :parent_id => nil
            ),
            :locale_or_role => :admin

      @page.reload
      expect(@page.slug).to eq 'new-slug'
      expect(@page.priority).to eq 2
      expect(@page.enabled).to eq false
      expect(@page.parent_id).to eq nil
    end
  end
end