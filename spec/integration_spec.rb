require 'fileutils'
require_relative '../site_generator_controller'

describe 'SiteGeneratorController Integration Test' do
  let(:site_name) { 'BananaLanda' }

  after do
    begin
      FileUtils.rm_r(site_name, secure: true)
    rescue Errno::ENOENT
      # Ignore
    end
  end

  specify do
    controller = SiteGeneratorController.new(
      site_name: site_name,
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
  end
end
