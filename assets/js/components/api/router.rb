require 'clearwater/component'

class API
  class Router
    include Clearwater::Component

    def render
      ClassDoc.new(
        name: 'Clearwater::Router',
        description: 'Helps you define routes that will determine which components get rendered based on the URL path',
        methods: [
          MethodDoc.new(
            name: 'initialize(location: Bowser.window.location, history: Bowser.window.history, &block)',
            description: [
              p(<<-EOF),
                Sets up the router with a tree of routes for the application.
              EOF
            ],
            arguments: {
              location: span([
                'an object that responds to ',
                code('path'),
                ' and ',
                code('href'),
                ' with the current path and URL, respectively. If an application depends on a hard navigation (such as what happens with a default ',
                code('a'),
                ' tag), the ',
                code('location'),
                ' object must also respond to ',
                code('href=(new_location)'),
                '.',
              ]),
              history: span([
                'an object that responds to ',
                code('push(url)'),
                ' which will add the given URL to the navigation history and ',
                code('back'),
                ' which will pop the last URL off of the navigation history.',
              ]),
              block: 'the declaration of the routing tree',
            },
          ),
          MethodDoc.new(
            name: 'navigate_to(path)',
            description: [
              p('Push the given path onto the history'),
            ],
            arguments: {
              path: 'the new URL path to use',
            },
          ),
          MethodDoc.new(
            name: 'navigate_to_remote(url)',
            description: [
              p('Hard-navigate to the given URL'),
            ],
            arguments: {
              url: 'the URL to navigate to',
            },
          ),
        ]
      )
    end
  end
end
