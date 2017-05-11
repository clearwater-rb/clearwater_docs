require 'clearwater/component'

class API
  class SVGComponent
    include Clearwater::Component

    def render
      h1 'SVGComponent'
    end
  end
end
