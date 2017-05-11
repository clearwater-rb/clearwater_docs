require 'class_doc'
require 'method_doc'

class API
  class Application
    include Clearwater::Component

    def render
      ClassDoc.new(
        name: 'Clearwater::Application',
        description: [
          p('The application object that wraps your UI.'),
          p('It is important to remember that rendering in Clearwater is asynchronous. If you want something to execute after rendering is complete, you will need to pass a block to the method you are using to render.'),
        ],
        class_methods: [
          MethodDoc.new(
            name: '.new(component:, router: Router.new, element: Bowser.document.body)',
            description: 'Sets up a Clearwater application object. Note that this method accepts keyword arguments rather than positional ones.',
            arguments: {
              component: 'The root component to render (sometimes referred to as the "layout"). This is the only required argument.',
              router: 'Optional router object, defaults to no routing',
              element: 'Optional element to render into. Defaults to the document body.',
            },
          ),
        ],
        methods: [
          MethodDoc.new(
            name: 'call(&block)',
            description: [
              p([
                'The "invocation" of a Clearwater app. The application begins monitoring the URL and responds to all ',
                code('Component#call'),
                ' by re-rendering itself.',
              ]),
            ],
            arguments: {
              block: 'An optional block to invoke after the app has been rendered',
            },
          ),
          MethodDoc.new(
            name: 'render(&block)',
            description: div([
              'Re-render the application. Does not check for URL changes and does not require the application to have been invoked with ',
              code('call'),
              '.',
            ]),
            arguments: {
              block: 'an optional block to invoke after the app has been rendered',
            },
          ),
          MethodDoc.new(
            name: 'render_current_url(&block)',
            description: 'Adjusts the render tree based on the URL and re-renders the application',
            arguments: {
              block: 'an optional block to invoke after the app has finished rendering',
            },
          ),
          MethodDoc.new(
            name: 'unmount',
            description: 'Removes the application from the app registry and causes it to stop listening to URL changes',
          ),
        ],
      )
    end
  end
end
