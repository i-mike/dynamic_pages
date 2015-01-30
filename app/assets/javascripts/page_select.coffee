$ ->
  new PageSelect(".page-select")

class PageSelect
  constructor: (select_id) ->
    $(select_id).select2
      allowClear: true
      templateResult: (page) ->
        return page.text if page.loading
        spaces_count = $(page.element).data('depth') * 4 || 2
        "<div class='page-select-item'>#{Array(spaces_count).join ' '}#{page.text}</div>"

#class PageSelect
#  constructor: (select_id) ->
#    $(select_id).select2
##      placeholder:
#      ajax:
#        url: "/#{window.current_localization()}/admin/pages.json"
##        delay: 250
##        url: "https://api.github.com/search/repositories"
#        dataType: 'json'
#        data: (params) ->
#          list: true
#        processResults: (data, params) ->
#          current_page_id = window.current_page()
#          current_element = null
#          current_element_index = null
#          for element, index in data
#            if element.attr.slug == current_page_id
#              current_element = element
#              current_element_index = index
#              break
#
#          current_element.disabled = true
#          if current_element
#            for element, index in data when index > current_element_index
#              if element.attr.depth > current_element.attr.depth
#                element.disabled = true
#              else
#                break
#
#          results: data
#
#      templateResult: (page) ->
#        return page.text if page.loading
#        spaces_count = page.attr.depth * 4
#        "<div class='page-select-item'>#{Array(spaces_count).join ' '}#{page.text}</div>"
#
#      templateSelection: (page) ->
#        page.text
#
#      current: (element, callback) ->
#        console.log("adads")


#        results: (data) ->
#          results: data

#        results: (data) ->
#          results = []
#          $.each(data, (index, item) ->
#            results.push(
#              id: item.id
#              text: item.text
#            )
#          )
#          results:
#            results

#      templateResult: (page) ->
#        console.log "templateResult"
#        "sd"
#        data: (pages) ->
#          console.log(pages)
#          data
#        delay: 250
#        processResults: (data, page) ->
#          console.log(data)
#          data
#      minimumInputLength: 1