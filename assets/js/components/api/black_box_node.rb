require 'clearwater/component'

class API
  class BlackBoxNode
    include Clearwater::Component

    def render
      ClassDoc.new(
        name: 'Clearwater::BlackBoxNode',
        description: span([
          'A mixin that signifies that your component is not managed by Clearwater, but is a black box that is only told that it is being mounted, updated, or unmounted. It is not loaded by default, so you must ',
          code("require 'clearwater/black_box_node'"),
          ' in order to use this mixin.',
        ]),
        example: Example.new,
        methods: [
          MethodDoc.new(
            name: 'node',
            description: 'Override this method to tell Clearwater what to render initially for this component',
            return_value: [
              'A ',
              code('Bowser::Element'),
              ' or ',
              code('Clearwater::Component'),
              '. Defaults to an empty ',
              code('div'),
              '.',
            ],
          ),
          MethodDoc.new(
            name: 'mount(element)',
            description: 'The method called when this component is mounted.',
            arguments: {
              element: [
                'A ',
                code('Bowser::Element'),
                ' created from the return value of the ',
                code('node'),
                ' method.',
              ],
            },
          ),
          MethodDoc.new(
            name: 'update(previous, element)',
            description: 'This method is called when there was previously another instance of this class in this spot in the render tree. Override to manually update the DOM.',
            arguments: {
              previous: [
                'The previous instance of this ',
                code('BlackBoxNode'),
              ],
              element: [
                'The same element passed into the ',
                code('mount'),
                ' method.',
              ],
            },
          ),
          MethodDoc.new(
            name: 'unmount(element)',
            description: "This method is called when there isn't a new instance of this BlackBoxNode to update with",
            arguments: {
              element: [
                'The element passed into the ',
                code('mount'),
                ' and ',
                code('update'),
                ' methods.',
              ],
            },
          ),
        ],
      )
    end

    class Example
      include Clearwater::Component
      include Clearwater::BlackBoxNode

      def node
        pre(code(<<-CODE))
class Map
  include Clearwater::BlackBoxNode

  attr_reader :map, :marker

  def initialize(position)
    @position = position
  end

  # Start with a 600x600 container for our map
  def node
    # Note that we fully qualify the div method as being in Clearwater::Component.
    # This is because we didn't include that mixin above. No point in including so
    # many methods only to use one of them one time.
    Clearwater::Component.div(
      style: {
        width: '600px',
        height: '600px',
      },
    )
  end

  # Called the first time this is added to the render tree, so we render into it.
  def mount(element)
    # Google Maps requires the element to be in the DOM, but when this method
    # is called, the element is only just created in memory but not part of the
    # DOM. This is to prevent unnecessary page reflows, but does require us to
    # delay rendering a map until the next animation frame.
    Bowser.window.animation_frame do
      @map = Google::Map.new(element, center: @position, zoom: 13)
      @marker = Google::Marker.new(@position, map: @map)
    end
  end

  # Move the center and marker to the new position
  def update(previous, _)
    # Copy over the map and marker from the previous instance so we have
    # something to work with.
    @map = previous.map
    @marker = previous.marker

    @map.center = @position
    @marker.position = @position
  end

  def unmount(element)
    # We don't need to do anything here. Google maps clean up after themselves.
  end
end
        CODE
      end

      def mount(element)
        `hljs.highlightBlock(#{element.to_n})`
      end
    end
  end
end
