require 'clearwater/component'

class API
  class DOMReference
    include Clearwater::Component

    def render
      h1 'DOMReference'
    end
  end
end
