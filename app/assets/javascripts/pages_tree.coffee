$ ->
  tree = new FTree('#f_tree')


class FTree
  constructor: (div_id) ->
#    @locale = window.location.pathname.split("/")[1]
    @locale = window.current_localization()
    @tree = $(div_id)
    @tree.fancytree
      source:
        url: "/#{@locale}/admin/pages.json?tree=true"

      init: (event, data) =>
        @.onTreeLoaded(event, data)

      activate: (event, data) =>
        @.onNodeSelected(event, data)

  onNodeSelected: (event, data) ->
    console.log("asdad")
    if event.which == 1
#      window.location.replace data.node.data.page_url
      window.open(data.node.data.page_url, '_top')

  onTreeLoaded: (event, data) ->
    @tree.fancytree("getRootNode").visit (node) ->
      node.setExpanded(true)

    current_page = @.get_current_page_from_url()
    current_page.setActive() if current_page

  get_current_page_from_url: ->
    path_parts = window.location.pathname.split("/")
    for element, index in path_parts when element is "pages"
      id = path_parts[index+1]

    @tree.fancytree("getTree").getNodeByKey(id)