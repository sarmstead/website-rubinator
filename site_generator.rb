class SiteGenerator
  attr_reader :site_name

  def initialize(site_name:, author: '', js_folder: false, css_folder: false)
    @site_name = site_name
  end

  def create_site_directory
    Dir.mkdir(site_name)
  end

  def create_index
    IO.write("#{site_name}/index.html")
  end
end
