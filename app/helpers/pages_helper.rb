module PagesHelper
  def pages_options_for_select(current_page)
    result = nested_ordered_hash_to_flat_array(Page.with_localized_content.hash_tree)
    disabled_pages = current_page.self_and_descendant_ids

    options_for_select result,
                       selected: current_page.parent_id,
                       disabled: disabled_pages
  end

  private

  def nested_ordered_hash_to_flat_array(hash, arr=[])
    # hash.each { |k, r| nested_ordered_hash_to_flat_array(r, arr << k) }
    hash.each { |k, r| nested_ordered_hash_to_flat_array(r, arr << [ k.localized_title, k.id, { 'data-depth' => k.depth } ]) }
    arr
  end

end
