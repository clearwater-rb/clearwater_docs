require 'class_doc'
require 'method_doc'

class API
  class Component
    include Clearwater::Component

    def render
      ClassDoc.new(
        name: 'Clearwater::Component',
        description: 'The most basic building block of the UI.',
        methods: [
          MethodDoc.new(
            name: 'render',
            description: [
              p('Override this method to determine what content your component renders'),
            ],
            return_value: 'a virtual-DOM node',
          ),
          MethodDoc.new(
            name: 'call',
            description: [
              p('Re-render all mounted Clearwater applications'),
            ],
            arguments: {
              block: 'block to execute after all apps are re-rendered',
            },
          ),
        ] + HTML_TAGS.map { |tag_name|
          starts_with_vowel = %w(a e i o u).any? do |vowel|
            tag_name.start_with? vowel
          end

          MethodDoc.new(
            name: tag_name,
            # description: p([
            #   "Renders a#{'n' if starts_with_vowel } ",
            #   code({ style: { font_size: '1.15em' } }, tag_name),
            #   ' element',
            # ]),
            arguments: {
              properties: 'Properties for the DOM node',
              content: 'Text, a component, other virtual-DOM node, or an array of any combination of these',
            },
            return_value: span([
              "a virtual-DOM node representing a#{'n' if starts_with_vowel} ",
              code(tag_name),
              ' element',
            ]),
          )
        },
      )
    end
  end
end
