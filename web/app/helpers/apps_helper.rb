module AppsHelper
  def app_show(app)
    # TODO shouldn't have to specify width, thumb doesn't work with default_url
    raw("<a href=\"#{app_url(app)}\" rel=\"tooltip\" class=\"tooltipped\" title=\"#{app.name}\">#{image_tag app.logo.url(:thumb), width: '60'}</a>")
  end
end
