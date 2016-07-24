require 'clearwater/component'
require 'components/code_block'

class Guides
  class Setup
    include Clearwater::Component

    def render
      article([
        h2('Installation and Setup'),
        p(<<-EOP),
          There are several ways you can compile a Clearwater app, but the
          simplest is the Rails asset pipeline if you're already using Rails.
        EOP

        h3('Rails 4.x'),
        p([
          'The ',
          code('opal-rails'),
          ' gem hooks into the Rails asset pipeline to compile your Clearwater app for you.',
        ]),

        p('Add these lines to your Gemfile:'),
        CodeBlock.new(<<-EOC),
gem 'clearwater', '~> 1.0.0.rc1'
gem 'opal-rails'
        EOC

        p([
          'After running ',
          code('bundle install'),
          ', you will need to rename ',
          code('app/assets/javascripts/application.js'),
          ' to ',
          code('application.rb'),
          ' and replace its contents with this:',
        ]),
        CodeBlock.new(<<-EOC),
require 'opal'
require 'clearwater'

class Layout
  include Clearwater::Component

  def render
    h1('Hello, world!')
  end
end

app = Clearwater::Application.new(component: Layout.new)
app.call
        EOC

        h3('Roda'),
        p("Add these lines to your Gemfile:"),
        CodeBlock.new(<<-EOC),
gem 'clearwater', '~> 1.0.0.rc1'
gem 'roda'
gem 'roda-opal_assets'
        EOC

        p([
          'Then create a ',
          code('config.ru'),
          ' file in your app directory with this code:',
        ]),
        CodeBlock.new(<<-EOC),
require 'bundler/setup'
Bundler.require

class App < Roda
  assets = Roda::OpalAssets.new

  route do |r|
    assets.route r

    <<-HTML
<!DOCTYPE html>
<html>
  <head>
    <title>Clearwater App</title>
  </head>
  <body>
    \#{assets.js 'app'}
  </body>
</html>
    HTML
  end
end

run App
        EOC

        p([
          'And then, in ',
          code('assets/js/app.rb'),
          ':',
        ]),
        CodeBlock.new(<<-EOC),
require 'opal'
require 'clearwater'

class Layout
  include Clearwater::Component

  def render
    h1('Hello, world!')
  end
end

app = Clearwater::Application.new(component: Layout.new)
app.call
        EOC
      ])
    end
  end
end
