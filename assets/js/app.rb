require 'opal'
require 'clearwater'

require 'components/guides'
require 'components/guides/setup'
require 'components/guides/rendering'
require 'components/guides/event_handling'
require 'components/layout'
require 'components/api'
require 'components/api/component'
require 'components/api/application'
require 'components/api/router'
require 'components/api/cached_render'
require 'components/api/black_box_node'
require 'components/api/dom_reference'
require 'components/api/svg_component'
require 'components/api/virtual_dom'

router = Clearwater::Router.new do
  # Interactive guides
  route 'guides' => Guides.new do
    route 'setup' => Guides::Setup.new
    route 'rendering' => Guides::Rendering.new
    route 'events' => Guides::EventHandling.new
  end

  # API Reference
  route 'api' => API.new do
    route 'component' => API::Component.new
    route 'application' => API::Application.new
    route 'router' => API::Router.new
    route 'cached_render' => API::CachedRender.new
    route 'black_box_node' => API::BlackBoxNode.new
    route 'dom_reference' => API::DOMReference.new
    route 'svg_component' => API::SVGComponent.new
    route 'virtual_dom' => API::VirtualDOM.new
  end
end

app = Clearwater::Application.new(
  component: Layout.new,
  router: router,
)
app.call do
  hash = `window.location.hash`
  unless hash.empty?
    scroll_element = Bowser.document[hash]
    if scroll_element
      scroll_element.scroll_into_view
    end
  end
end
