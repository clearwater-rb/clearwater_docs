require 'clearwater/component'
require 'clearmarked'

class API
  include Clearwater::Component

  def render
    article([
      h1({ id: 'api' }, 'API'),
      outlet || Clearmarked.call(<<-MD),
Clearwater has a few major concepts:

1. [`Component`](/api/component)
1. [`Router`](/api/router)
1. [`Application`](/api/application)
1. [`CachedRender`](/api/cached_render)
1. [`BlackBoxNode`](/api/black_box_node)
1. [`MemoizedComponent`](/api/memoized_component)
1. [`DOMReference`](/api/dom_reference)
1. [`SVGComponent`](/api/svg_component)
1. [`VirtualDOM`](/api/virtual_dom)
      MD
    ])
  end
end
