require 'fileutils'
require 'debug'
require_relative '../site_generator_controller'

describe 'SiteGeneratorController Integration Test' do
  let(:site_name) { 'BananaLanda' }

  after do
    FileUtils.rm_r(site_name, secure: true)
  rescue Errno::ENOENT
    # Ignore
  end

  specify('Happy Path 🥳') do
    controller = SiteGeneratorController.new(
      site_name:,
      author_name: 'George',
      js_directory: true,
      css_directory: true
    )

    controller.create_site

    expect(Dir.exist?(site_name)).to eq true
    expect(File.exist?("#{site_name}/index.html")).to eq true
    expect(Dir.exist?("#{site_name}/js")).to eq true
    expect(Dir.exist?("#{site_name}/css")).to eq true
    expect(controller.details).to include("Created #{site_name}")
    expect(controller.details).to include("Created #{site_name}/index.html")
    expect(controller.details).to include("Created #{site_name}/js")
    expect(controller.details).to include("Created #{site_name}/css")
  end

  specify('Set options 🛠️') do
    controller = SiteGeneratorController.new(
      site_name:,
      author_name: 'George',
      js_directory: false,
      css_directory: false
    )

    controller.create_site

    expect(controller.details).to_not include("Created #{site_name}/js")
    expect(controller.details).to_not include("Created #{site_name}/css")
  end

  specify('Sad Path 😭') do
    Dir.mkdir(site_name)

    controller = SiteGeneratorController.new(
      site_name:,
      author_name: 'George',
      js_directory: true,
      css_directory: true
    )

    controller.create_site

    expect(controller.errors).to include("'#{site_name}' directory already exists")
  end
end
