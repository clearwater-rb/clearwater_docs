require 'clearwater/component'

class API
  class CachedRender
    include Clearwater::Component

    def render
      ClassDoc.new(
        name: 'Clearwater::CachedRender',
        description: p([
          'Include this mixin into your component to allow Clearwater to reuse previous values returned by ',
          code('render'),
          '.',
        ]),
        methods: [
          MethodDoc.new(
            name: 'should_render?(previous)',
            description: 'Override this method to tell Clearwater when to invalidate the cache.',
            arguments: {
              previous: 'The previous instance of this component at this node in the render tree',
            },
            return_value: [
              'Return ',
              code('true'),
              ' to tell Clearwater to go ahead and re-render this component. Return ',
              code('false'),
              ' to indicate that it should be left alone.',
            ],
            example: CodeBlock.new(<<-CODE),
class UserList
  include Clearwater::Component
  include Clearwater::CachedRender

  attr_reader :users

  def initialize(users)
    @users = users
  end

  # We only re-render if the list of users is not the same as it was on the
  # last render.
  def should_render?(previous)
    users != previous.users
  end

  def render
    ul(users.map { |user|
      li(user.name)
    })
  end
end
            CODE
          ),
        ],
      )
    end

    class ShouldRenderExample
      include Clearwater::Component
      include Clearwater::BlackBoxNode

      def key
        example_code
      end

      def node
        pre(code(example_code))
      end

      def mount element
        `hljs.highlightBlock(#{element.to_n})`
      end

      def example_code
      end
    end
  end
end
