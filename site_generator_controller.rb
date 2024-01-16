require_relative './site_generator'

class SiteGeneratorController
  attr_reader :details, :errors

  def initialize(args)
    @site_generator = SiteGenerator.new(**args)
    @details = []
    @errors = []
  end

  def create_site
    create_site_directory
    return if errors.any?

    create_site_index
    create_js_directory
    create_css_directory
  end

  private

  attr_reader :site_generator

  def create_site_directory
    details << "Created #{site_generator.create_site_directory}"
  rescue DirectoryExistsError => e
    errors << "'#{e.message}' directory already exists"
  end

  def create_site_index
    details << "Created #{site_generator.create_index}"
  end

  def create_js_directory
    create_sub_directory(
      site_generator.create_js_directory
    )
  end

  def create_css_directory
    create_sub_directory(
      site_generator.create_css_directory
    )
  end

  def create_sub_directory(dir_name)
    return unless dir_name

    details << "Created #{dir_name}"
  end
end
