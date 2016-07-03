require 'clearwater/component'
require 'clearwater/cached_render'
require 'clearwater/link'

class NavLink
  include Clearwater::Component
  include Clearwater::CachedRender

  def initialize content, path, properties={}
    @content = content
    @path = path
    @properties = defaults_with(properties.merge(href: path))
  end

  def render
    Link.new(@properties, @content)
  end

  def defaults_with properties
    properties.each_with_object(defaults) do |(key, value), hash|
      if key == :style
        hash[:style].merge! value
      else
        hash[key] = value
      end
    end
  end

  def defaults
    {
      style: {
        display: 'inline-block',
        margin: '5px 8px',
        color: :blue,
        text_decoration: :none,
        font_family: ['Helvetica Neue', 'sans-serif'],
        font_weight: :normal,
      },
    }
  end
end
