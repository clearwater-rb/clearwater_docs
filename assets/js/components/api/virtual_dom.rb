require 'clearwater/component'

class API
  class VirtualDOM
    include Clearwater::Component

    def render
      div([
        h1('VirtualDOM'),
        p([
          'Not yet written. Feel free to submit a pull request to the ',
          a({
            href: 'https://github.com/clearwater-rb/clearwater_docs',
            target: :_blank,
          }, 'documentation repo'),
          '.',
        ]),
      ])
    end
  end
end
