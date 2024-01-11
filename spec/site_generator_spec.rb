require_relative '../site_generator'

describe SiteGenerator do
  before do
    allow(Dir).to receive(:mkdir).and_return(0)
  end

  it 'creates a site directory' do
    site_name = 'awesome site'
    site_generator = SiteGenerator.new(site_name: site_name)
    site_generator.create_site_directory
    expect(Dir).to have_received(:mkdir).with(site_name)
  end
end
