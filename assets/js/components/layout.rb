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
    ])
  end

  module Style
    module_function

    def app
      {
        width: '1024px',
        margin: :auto,
      }
    end
  end
end
