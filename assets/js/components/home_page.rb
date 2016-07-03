require 'clearwater/component'

require 'components/code_block'

class HomePage
  include Clearwater::Component

  def render
    article({ style: Style.page }, [
      h2('The best way to write front-end web apps in Ruby'),
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

      h3("Let's have a look at what's happening"),
      CodeBlock.new("require 'opal'"),
      p("This loads the Opal runtime. If you're loading Opal from a CDN, you don't need this."),

      CodeBlock.new("require 'clearwater'"),
      p("This loads the Clearwater framework."),

      CodeBlock.new(<<-EOC),
class Layout
  include Clearwater::Component

  def render
    h1('Hello, world!')
  end
end
      EOC
      p([
        "This is a simple component that just renders an ",
        code('h1'),
        " tag. A component is an object that has a ",
        code('render'),
        " method that returns a virtual-DOM tree."
      ]),

      CodeBlock.new("app = Clearwater::Application.new(component: Layout.new)"),
      p([
        "This line sets up an application that uses a ",
        code('Layout'),
        " as its root component.",
      ]),

      CodeBlock.new("app.call"),
      p(<<-EOF),
        This invokes the Clearwater app. It registers it with the app registry
        (in case you have multiple apps on one page), renders it, and does any
        other necessary setup.
      EOF
    ])
  end

  module Style
    module_function

    def page
      {
        width: '1024px',
        margin: :auto,
      }
    end
  end
end
