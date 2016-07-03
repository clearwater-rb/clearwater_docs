require 'opal'
require 'clearwater'

require 'components/guides'
require 'components/guides/setup'
require 'components/guides/rendering'
require 'components/guides/event_handling'
require 'components/layout'
require 'components/api'

router = Clearwater::Router.new do
  # Interactive guides
  route 'guides' => Guides.new do
    route 'setup' => Guides::Setup.new
    route 'rendering' => Guides::Rendering.new
    route 'events' => Guides::EventHandling.new
  end

  # API Reference
  route 'api' => API.new
end

Clearwater::Application.new(
  component: Layout.new,
  router: router,
).call
