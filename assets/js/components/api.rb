require 'components/api'

class API
  include Clearwater::Component

  def render
    article([
      h1('API')
    ])
  end
end
