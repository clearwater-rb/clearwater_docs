require 'clearwater/component'
require 'clearwater/black_box_node'

require 'highlight.js'

class CodeBlock
  include Clearwater::Component
  include Clearwater::BlackBoxNode

  def initialize code, lang: :ruby
    @code = code
    @lang = lang
  end

  def node
    pre({ style: Style.pre }, code({ class_name: @lang }, @code))
  end

  def mount node
    `hljs.highlightBlock(#{node.to_n}.children[0])`
  end

  module Style
    module_function

    def pre
      {
        width: '95%',
        margin: :auto,
      }
    end
  end
end
