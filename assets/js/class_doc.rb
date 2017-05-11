require 'clearwater/component'

class ClassDoc
  include Clearwater::Component

  def initialize(name:, description:, class_methods: [], methods: [], example: nil)
    @name = name
    @description = description
    @class_methods = class_methods
    @methods = methods
    @example = example
  end

  def render
    div([
      h2({ id: id }, @name),
      div(@description),
      if @example
        div([
          h3('Example'),
          div(@example),
        ])
      end,
      unless @class_methods.empty?
        [
          h3('Class Methods'),
          ul(
            {
              style: {
                list_style: :none,
                padding: 0,
              },
            },
            @class_methods.map { |method|
              li(method)
            }
          )
        ]
      end,
      unless @methods.empty?
        [
          h3('Instance Methods'),
          ul(
            {
              style: {
                list_style: :none,
                padding: 0,
              },
            },
            @methods.map { |method|
              li(method)
            }
          )
        ]
      end,
    ])
  end

  def id
    "class-#{@name.to_s.gsub(/\W+/, '-')}"
  end
end
