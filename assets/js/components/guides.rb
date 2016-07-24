require 'clearwater/component'

class Guides
  include Clearwater::Component

  def render
    div([
      header([
        h1('Guides'),
        nav({ style: Style.nav }, [
          # These are Guides::Links, not plain Clearwater Links
          # TODO: Create these guides
          Link.new('Installation/Setup', 'setup'),
          Link.new('Rendering', 'rendering'),
          Link.new('Handling Events', 'events'),
        ]),
      ]),

      outlet || default_content
    ])
  end

  def default_content
    p('Choose a guide')
  end

  class Link
    include Clearwater::Component

    def initialize label, path
      @label = label
      @path = path
    end

    def render
      ::Link.new({ href: "/guides/#{@path}", style: Style.link }, @label)
    end
  end

  module Style
    module_function

    def nav
      {
        list_style: :none,
        padding_left: 0,
      }
    end

    def link
      {
        color: :blue,
        display: 'inline-block',
        padding: '5px 8px',
      }
    end
  end
end
