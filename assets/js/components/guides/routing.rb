require 'clearwater/component'
require 'components/code_block'

class Guides
  class Routing
    include Clearwater::Component

    def render
      article([
        h2('Routing'),
        p(<<-EOP),
          Routing matches segments of the URL path to a path through a tree of
          components. Your application has a single, central router that wires
          this up on every render.
        EOP

        p([
          'For example, given the ',
          a({ href: 'https://github.com/clearwater-rb/clearwater_docs/blob/6745fd8ad4ad01c13557e210ceef272ae675f10b/assets/js/app.rb#L20-L40', }, 'routing tree for this documentation app'),
          ':',
        ]),

        CodeBlock.new(<<-EOC),
router = Clearwater::Router.new do
  route 'guides' => Guides.new do
    route 'setup' => Guides::Setup.new
    route 'rendering' => Guides::Rendering.new
    route 'routing' => Guides::Routing.new
    route 'events' => Guides::EventHandling.new
  end

  route 'api' => API.new do
    route 'component' => API::Component.new
    route 'application' => API::Application.new
    route 'router' => API::Router.new
    route 'cached_render' => API::CachedRender.new
    route 'black_box_node' => API::BlackBoxNode.new
    route 'memoized_component' => API::MemoizedComponent.new
    route 'dom_reference' => API::DOMReference.new
    route 'svg_component' => API::SVGComponent.new
    route 'virtual_dom' => API::VirtualDOM.new
  end
end
        EOC

        p([
          'If we go to the path ',
          code('/guides/routing'),
          ', then we will render a ',
          code('Guides'),
          ' component whose child route (called an ',
          code('outlet'),
          ') is a ',
          code('Guides::Routing'),
          '. The reason we call it an outlet is because that is the method you call to render the child route. You use ',
          code('outlet'),
          'to tell Clearwater that your child route is rendered in exactly this spot in the DOM:'
        ]),

        CodeBlock.new(<<-EOC),
class Container
  include Clearwater::Component

  def render
    div([
      p('This part is above the child route'),
      outlet,
      p('This part is below the child route'),
    ])
  end
end
        EOC

        p(<<-EOP),
          You can think of it as dependency injection. Clearwater tells your
          components that act as routing targets what their child route is and
          that component, in return, tells Clearwater where it goes.
        EOP
      ])
    end
  end
end
