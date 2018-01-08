require 'clearwater/component'
require 'components/code_block'

class API
  class SVGComponent
    include Clearwater::Component

    def render
      ClassDoc.new(
        name: 'Clearwater::SVGComponent',
        description: 'A component mixin for building SVG scenes.',
        example: Example.new,
        methods: [
          MethodDoc.new(
            name: 'render',
            description: 'Override this method to determine what content your SVGComponent renders',
            return_value: 'a virtual-DOM node with your SVG scene',
          ),
        ] + Clearwater::SVGComponent::SVG_TAGS.map { |tag_name, svg_tag|
          if %w(a e i o u).any? { |vowel| tag_name.start_with? vowel }
            indefinite_article = 'an'
          else
            indefinite_article = 'a'
          end
          mdn_url = "https://developer.mozilla.org/en-US/docs/Web/SVG/Element/#{svg_tag}"

          MethodDoc.new(
            name: tag_name,
            arguments: {
              properties: 'Properties for the SVG node in the DOM',
              content: 'Text, a component, another SVG node, or an array of any combination of these',
            },
            return_value: span([
              "a virtual-DOM node representing #{indefinite_article} ",
              a({ href: mdn_url, target: :_blank }, code(svg_tag)),
              ' node',
            ]),
          )
        }
      )
    end

    class Example
      include Clearwater::Component

      def render
        Bowser.window.delay(60) { call }

        div([
          CodeBlock.new(<<-CODE),
class Clock
  include Clearwater::SVGComponent

  def initialize(time)
    @time = time
  end

  def render
    # Your scene must be wrapped in an <svg> element. The :view_box is an SVG
    # abstraction letting you ignore the pixel dimensions and focus on building
    # the scene in whatever units you choose. Here we make a 100x100 scene.
    svg({ view_box: '0 0 100 100' }, [
      # Clock face, centered at 50,50
      circle(
        cx: 50,
        cy: 50,
        r: 49,
        stroke: :black,
        fill: :transparent,
      ),

      # Minute hand
      line(
        # Start at the center of the clock face
        x1: 50, y1: 50,
        # Go straight up, but not all the way
        x2: 50, y2: 10,
        stroke: :black,
        stroke_width: 2, # 2 units wide
        # Rotate around the clock by how far we are through the hour
        transform: "rotate(\#{360 * @time.min / 60} 50 50)",
      ),

      # Hour hand
      line(
        # Same as the minute hand, start at the center and go straight up, but make it
        # shorter than the minute hand
        x1: 50, y1: 50,
        x2: 50, y2: 20,
        stroke: :black,
        stroke_width: 4, # A little wider than the minute hand
        # One full turn around the clock is 12 hours, so we just need to rotate by a fraction of that.
        transform: "rotate(\#{360 * @time.hour / 12} 50 50)",
      ),

      # Timestamp inside the clock
      text({
        x: 50, y: 30,
        text_anchor: :middle,
        style: { font_size: 5 }, # If it's 100 units tall, this will be 5% of that
      }, [
        time.strftime('%I:%M %P'),
      ]),
    ])
  end
end
          CODE
          Clock.new,
        ])
      end
    end

    class Clock
      include Clearwater::SVGComponent

      def render
        time = Time.now

        # Make a 100x100 scene
        svg({
          view_box: '0 0 100 100',
          style: {
            max_width: '300px',
          },
        }, [
          # Clock face, centered at 50,50
          circle(
            cx: 50,
            cy: 50,
            r: 49,
            stroke: :black,
            fill: :transparent,
          ),

          # Minute hand
          line(
            # Start at the center of the clock face
            x1: 50, y1: 50,
            # Go straight up, but not all the way
            x2: 50, y2: 10,
            stroke: :black,
            stroke_width: 2, # 2 units wide
            # Rotate around the clock by how far we are through the hour
            transform: "rotate(#{360 * time.min / 60} 50 50)",
          ),

          # Hour hand
          line(
            # Same as the minute hand, start at the center and go straight up, but make it shorter than the minute hand
            x1: 50, y1: 50,
            x2: 50, y2: 20,
            stroke: :black,
            stroke_width: 4, # A little wider than the minute hand
            # One full turn around the clock is 12 hours, so we just need to rotate by a fraction of that.
            transform: "rotate(#{360 * time.hour / 12} 50 50)",
          ),

          text({
            x: 50, y: 30,
            text_anchor: :middle,
            style: { font_size: 5 },
          }, [
            time.strftime('%I:%M %P'),
          ]),
        ])
      end
    end
  end
end
