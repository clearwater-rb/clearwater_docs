require 'clearwater/component'

require 'components/nav_link'
require 'components/home_page'

class Layout
  include Clearwater::Component

  def render
    div({ style: Style.app }, [
      h1(NavLink.new('Clearwater', '/')),
      nav([
        NavLink.new('Guides', '/guides'),
        NavLink.new('API Reference', '/api'),
      ]),

      outlet || HomePage.new,

      footer({ style: Style.footer }, [
        p([
          "Clearwater and related gems were created by ",
          a({ href: 'https://twitter.com/jamie_gaskins' }, 'Jamie Gaskins'),
        ]),
      ]),
    ])
  end

  module Style
    module_function

    def app
      {
        background: :white,
        max_width: '1024px',
        margin: :auto,
        padding: '1em 2em',
        min_height: '100vh',
      }
    end

    def footer
      {
        text_align: :center,
      }
    end
  end
end
