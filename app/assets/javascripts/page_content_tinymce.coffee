$ ->
#  tree = new FTree('page_content_body')
  tinymce.init
    selector: '#page_content_body'
    plugins: [
      "advlist autolink lists link image charmap print preview anchor"
      "searchreplace visualblocks code fullscreen"
      "insertdatetime media table contextmenu paste"
    ]
    toolbar: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image"
    content_css: "/assets/bootstrap_and_overrides.css?body=1,/assets/pages.css?body=1"

#    setup: (editor) ->
#      editor.on('init', (e) ->
#        console.log editor
#      )

