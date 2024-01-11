require_relative './site_generator'

class SiteGeneratorController
  attr_reader :details

  def initialize(site_name:, author_name: '', js_directory: false, css_directory: false)
    @site_generator = SiteGenerator.new(site_name:, author_name:, js_directory:, css_directory:)
    @site_name = site_name
    @details = []
  end

  def create_site
    # site_generator.create_site_directory
    create_site_directory
    site_generator.create_index
    site_generator.create_js_directory
    site_generator.create_css_directory
  end

  private

  attr_reader \
    :site_generator,
    :site_name

  # def create_site_directory
  #   site_generator.create_site_directory
  #   details << "Created #{site_name}"
  # rescue adsadsf
  #   errors << 'directorys '
  # end

  def create_site_directory
    details << site_generator.create_site_directory
  rescue DirectoryExistsError => e
    errors << e
  end
end
