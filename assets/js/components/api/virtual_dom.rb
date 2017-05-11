require 'clearwater/component'

class API
  class VirtualDOM
    include Clearwater::Component

    def render
      h1 'VirtualDOM'
    end
  end
end
