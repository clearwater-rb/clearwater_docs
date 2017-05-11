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
          ),
        ],
      )
    end
  end
end
