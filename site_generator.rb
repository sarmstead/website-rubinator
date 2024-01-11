class SiteGenerator
  attr_reader :site_name, :author_name

  def initialize(site_name:, author_name: '', js_folder: false, css_folder: false)
    @site_name = site_name
    @author_name = author_name
  end

  def create_site_directory
    Dir.mkdir(site_name)
  end

  def create_index
    data = build_index_html
    IO.write("#{site_name}/index.html", data)
  end

  def build_index_html
    <<~HEREDOC
      <html>
        <head>
          <title>#{site_name}</title>
          <meta name="author" content="#{author_name}" />
        </head>
        <body>
          <h1>Welcome to #{site_name}.</h1>
          <h2>Time to monkey around.</h2>
        </body>
      </html>
    HEREDOC
  end
end
