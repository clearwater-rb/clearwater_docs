require 'clearwater/component'
require 'components/code_block'

class Guides
  class Rendering
    include Clearwater::Component

    def render
      article([
        h2('Rendering'),
        p(<<-EOP),
          Rendering in Clearwater is primarily a matter of connecting a tree of
          components.
        EOP

        h3('The component'),
        p([
          'Components use an HTML-like Ruby DSL provided by the ',
          code('Clearwater::Component'),
          ' mixin. Here is a minimal Clearwater component:',
        ]),

        CodeBlock.new(<<-EOC),
class MyComponent
  include Clearwater::Component

  def render
    div('foo')
  end
end
        EOC

        p('There are DSL methods for all of the HTML5 tag names.'),
        p('If you want to add DOM properties to the elements you are
           specifying, you can simply put a hash in front of the content:'),

        CodeBlock.new(<<-EOC),
def render
  # <div id="bar">foo</div>
  div({ id: 'bar' }, 'foo')
end
        EOC

        p("A DOM node that only contains one other node is not very interesting
           so you can pass in multiple nodes just by passing an array:"),

        CodeBlock.new(<<-EOC),
def render
  div([
    div('One div'),
    div('Two divs'),
  ])
end
        EOC
      ])
    end
  end
end
