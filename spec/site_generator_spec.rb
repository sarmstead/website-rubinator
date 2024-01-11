require_relative '../site_generator'

describe SiteGenerator do
  let(:site_name) { 'awesome site' }

  before do
    allow(Dir).to receive(:mkdir).and_return(0)
    allow(IO).to receive(:write)
  end

  it 'creates a site directory' do
    site_generator = SiteGenerator.new(site_name: site_name)
    site_generator.create_site_directory
    expect(Dir).to have_received(:mkdir).with(site_name)
  end

  it 'does not create a site directory if it exists' do
    allow(Dir).to receive(:mkdir).and_raise(Errno::EEXIST)
    site_generator = SiteGenerator.new(site_name: site_name)
    site_generator.create_site_directory
    expect
  end

  it 'creates an index.html file in site directory' do
    site_generator = SiteGenerator.new(site_name: site_name)
    site_generator.create_index
    expect(IO).to have_received(:write).with(
      "#{site_name}/index.html",
      anything
    )
  end

  it 'creates an index.html file with site name and author' do
    author_name = 'George of teh 🙊 Jungle 🍌'
    site_generator = SiteGenerator.new(site_name: site_name, author_name: author_name)
    site_generator.create_index
    ['html', 'head', 'body', author_name, site_name].each do |fragment|
      expect(IO).to have_received(:write).with(
        anything,
        match(fragment)
      )
    end
  end

  it 'does not create a js directory when not selected' do
    site_generator = SiteGenerator.new(site_name: site_name, js_directory: false)
    site_generator.create_js_directory
    expect(Dir).to_not have_received(:mkdir)
  end

  it 'creates a js directory inside of the site directory when selected' do
    site_generator = SiteGenerator.new(site_name: site_name, js_directory: true)
    site_generator.create_js_directory
    expect(Dir).to have_received(:mkdir).with("#{site_name}/js")
  end

  it 'does not create a css directory when not selected' do
    site_generator = SiteGenerator.new(site_name: site_name, css_directory: false)
    site_generator.create_css_directory
    expect(Dir).to_not have_received(:mkdir)
  end

  it 'creates a css directory inside of the site directory when selected' do
    site_generator = SiteGenerator.new(site_name: site_name, css_directory: true)
    site_generator.create_css_directory
    expect(Dir).to have_received(:mkdir).with("#{site_name}/css")
  end
end
