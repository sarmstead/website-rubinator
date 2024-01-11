require_relative '../site_generator'

describe SiteGenerator do
  before do
    allow(Dir).to receive(:mkdir).and_return(0)
    allow(IO).to receive(:write)
  end

  it 'creates a site directory' do
    site_name = 'awesome site'
    site_generator = SiteGenerator.new(site_name: site_name)
    site_generator.create_site_directory
    expect(Dir).to have_received(:mkdir).with(site_name)
  end

  it 'creates an index.html file in site directory' do
    site_name = 'awesome site'
    site_generator = SiteGenerator.new(site_name: site_name)
    site_generator.create_index
    expect(IO).to have_received(:write).with("#{site_name}/index.html")
  end
end
