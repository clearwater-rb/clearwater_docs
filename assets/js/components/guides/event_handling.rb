require 'clearwater/component'
require 'components/code_block'

class Guides
  class EventHandling
    include Clearwater::Component

    def render
      article([
        h2('Handling Events'),
        p_with_code(<<-EOP),
          Handling a click event is as simple as passing an `onclick` property.
        EOP

        CodeBlock.new(<<-EOC),
def render
  button({ onclick: proc { clicked! } }, 'Click me!')
end
        EOC

        p(<<-EOP),
          Handlers can be set for any events the element can handle. For
          example:
        EOP

        ul([
          li(code('onclick')),
          li(code('oninput')),
          li(code('onsubmit')),
          li(code('onkeyup')),
          li(code('onkeydown')),
          li(code('onfocus')),
          li(code('onblur')),
          li(code('onmouseover')),
          li(code('onload')),
          li(code('onerror')),
          li(code('onscroll')),
        ]),

        p_with_code(<<-EOP),
          Event handlers can be procs or lambdas (they compile down to JS
          `function`s), but can also be references to methods:
        EOP

        CodeBlock.new(<<-EOC),
def render
  button({ onclick: method(:clicked!) }, 'Click me!')
end
        EOC

        p_with_code(<<-EOP),
          In fact, your event handler can be any object that responds to `call`!
        EOP

        CodeBlock.new(<<-EOC),
class MyComponent
  include Clearwater::Component

  def render
    button({ onclick: Handler.new }, 'Click me!')
  end
end

class Handler
  def call
    puts 'Event handled!'
  end
end
        EOC
      ])
    end

    def p_with_code content
      p(content.split('`').map.with_index { |c, index|
        if index.even?
          c
        else
          code(c)
        end
      })
    end
  end
end
