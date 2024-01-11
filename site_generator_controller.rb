require_relative './site_generator'

class SiteGeneratorController
  def initialize(args)
    @site_generator = SiteGenerator.new(**args)
  end

  def create_site
    site_generator.create_site_directory
    site_generator.create_index
    site_generator.create_js_directory
    site_generator.create_css_directory
  end

  private

  attr_reader :site_generator
end
