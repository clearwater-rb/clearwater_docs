require 'clearwater/component'

class API
  class MemoizedComponent
    include Clearwater::Component

    def render
      ClassDoc.new(
        name: 'Clearwater::MemoizedComponent',
        description: 'A special type of component whose instances can be reused between renders.',
        methods: [
          MethodDoc.new(
            name: '.memoize(*args, &block)',
            description: 'Lets Clearwater know to either initialize or update a component of this class.',
            example: CodeBlock.new(<<-CODE),
# Calls either `initialize(0)` or `update(0)`, depending on whether we're
# rendering for the first time or re-rendering an existing one.
ClickCounter.memoize(0)
            CODE
          ),
          MethodDoc.new(
            name: '[](key)',
            description: [
              'Set the key for this ',
              code('MemoizedComponent'),
              ". Because we don't know which instance we're dealing with while we're generating the virtual-DOM nodes, if we have multiple instances of the same component we might need to identify them in case they're filtered or reordered."
            ],
            example: CodeBlock.new(<<-CODE),
Array.new(10) { |i| ClickCounter.memoize[i] }.shuffle
            CODE
          ),
          MethodDoc.new(
            name: 'initialize(*args, &block)',
            description: 'Override this method to set up initial state for a component on its first render',
          ),
          MethodDoc.new(
            name: 'update(*args, &block)',
            description: 'Override this method to receive or change existing state for this component on subsequent renders',
          ),
          MethodDoc.new(
            name: 'destroy',
            description: 'Override this method to perform some action when this component instance is being removed from the DOM'
          ),
        ],
        example: CodeBlock.new(<<-CODE),
# This component will use our MemoizedComponent below
class ClickCounter < Clearwater::MemoizedComponent
  def initialize(count=0)
    @count = count
  end

  # If the count is passed in, let's use that. Otherwise, just keep what we've got.
  def update(count=@count)
    @count = count
  end

  # Just for funsies, we're going to report our count to the server before it's
  # removed from the DOM.
  def destroy
    Bowser::HTTP.fetch('/api/clicks', data: { count: @count }, method: :post)
  end

  def render
    span([
      button({ onclick: method(:increment) }, '+'),
      ' ',
      @count,
    ])
  end
end
        CODE
      )
    end
  end
end
