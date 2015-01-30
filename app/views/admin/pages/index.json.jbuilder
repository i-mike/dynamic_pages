def json_ltree_builder( json, ltree_item )
  # ltree_item = ltree_item.first
  page = ltree_item.first
  json.key page.slug
  #
  # content = ltree_item.localized_content(Language.default)
  # content = page.page_contents
  # z = content.map { |i| "#{i.title[0..1]}" }
  # json.title content ? content.title : page.slug
  # json.title content ? page.localized_title : page.slug
  json.title page.localized_title || page.slug
  json.page_url url_for([:admin, page])
  # # TODO: add something for disabled page
  json.icon false
  # #
  # json.data do
  #   json.attr do
  #     json.id ltree_item.slug
  #     json.slug ltree_item.slug
  #     json.priority ltree_item.priority
  #   end

  #   # json.page_url url_for([:admin, ltree_item])
  # end
  # children = ltree_item.children

  children = ltree_item[1]
  unless children.empty?
  # unless children.nil?
    json.children do
      json.array! children do |child|
          json_ltree_builder( json, child )
      end
    end
  end
end
############################################




if params[:tree]
  json.array! @pages do |page|
    json_ltree_builder( json, page )
  end
else
  json.array!(@pages) do |page|
    json.extract! page, :id, :slug, :priority, :disabled
    json.url page_url(page, format: :json)
  end
end
