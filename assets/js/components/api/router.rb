require 'clearwater/component'

class API
  class Router
    include Clearwater::Component

    def render
      h1 'Router'
    end
  end
end
