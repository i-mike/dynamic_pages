module LanguagesHelper
  def language_selector
    Language.all.map do |lng|
      if request.params[:locale] == lng.slug
        lng.name
      else
        link_to lng.name, locale: lng.slug
      end

    end.join(' | ').html_safe
  end
end
