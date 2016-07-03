require 'clearwater/component'

require 'components/nav_link'
require 'components/home_page'

class Layout
  include Clearwater::Component

  def render
    div([
      h1(NavLink.new('Clearwater', '/')),
      nav([
        NavLink.new('Guides', '/guides'),
        NavLink.new('API Reference', '/api'),
      ]),

      outlet || HomePage.new,
    ])
  end
end
