class LocalizationConstraint
  def matches?(request)
    Language.available_languages.include? request.params[:locale]
  end
end