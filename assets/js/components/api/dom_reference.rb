require 'clearwater/component'

class API
  class DOMReference
    include Clearwater::Component

    def render
      ClassDoc.new(
        name: 'Clearwater::DOMReference',
        description: span([
          'A class that allows you to use real DOM nodes after they are created, as opposed to the virtual-DOM nodes generated within your ',
          code('render'),
          ' method. This class is not loaded by default, so you must ',
          code("require 'clearwater/dom_reference'"),
          ' in order to use it.',
        ]),
        example: Example.new,
        methods: [
          MethodDoc.new(
            name: 'method_missing(*args, &block)',
            description: [
              'A DOMReference will delegate all unhandled messages to the underlying ',
              code('Bowser::Element'),
              '. In the example above, we delegated ',
              code('value'),
              ' and ',
              code('clear'),
              '.',
            ],
          ),
          MethodDoc.new(
            name: 'mounted?',
            description: 'determines whether the reference has a node associated with it',
          ),
          MethodDoc.new(
            name: 'node',
            description: 'the DOM element associated with this reference',
          ),
        ],
      )
    end

    class Example
      include Clearwater::Component
      include Clearwater::BlackBoxNode

      def node
        pre(code(<<-CODE))
require 'clearwater/memoized_component'
require 'clearwater/dom_reference'
require 'bowser/http'

class LoginForm < Clearwater::MemoizedComponent
  def initialize
    @email = Clearwater::DOMReference.new
    @password = Clearwater::DOMReference.new
  end

  def render
    form({ onsubmit: method(:submit_credentials) }, [
      # Note we pass the references as the `ref` attribute
      input(type: :email, ref: @email),
      input(type: :password, ref: @password),
      button('Login'),
    ])
  end

  def submit_credentials(event)
    event.prevent # Don't let the browser actually submit the form

    Bowser::HTTP.fetch(
      '/api/tokens',
      data: {
        # Get the values of the input fields
        email: @email.value,
        password: @password.value,
      },
      method: :POST,
      headers: {
        'Content-Type': 'application/json',
      },
    )
      .then(&:json)
      .then do |response|
        ReceiveToken.call response[:token]

        # Clear the input fields
        @email.clear
        @password.clear
      end
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
