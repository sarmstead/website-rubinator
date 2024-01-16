require 'thor'
require_relative './string'
require_relative './site_generator_controller'

class Rubinator < Thor
  desc 'install', 'Welcome to the Rubinator...'

  def install
    site_name = ask('Okay, what should we name your website?')
    author_name = ask('Schweet. And your name?')
    js_directory = ask('Do you want a JS directory', limited_to: %w[y n])
    css_directory = ask('Do you want a CSS directory', limited_to: %w[y n])

    controller = SiteGeneratorController.new(
      site_name:,
      author_name:,
      js_directory: js_directory.to_boolean,
      css_directory: css_directory.to_boolean
    )

    controller.create_site

    if controller.errors.any?
      say('Yikes! We have the following errors:', :red)
      controller.errors.each do |error|
        say("- #{error}", :red)
      end
    end

    return unless controller.details.any?

    say('Nice job sparky.', :green)
    controller.details.each do |detail|
      say("- #{detail}", :green)
    end
  end
end
