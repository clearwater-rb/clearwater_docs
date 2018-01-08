require 'clearwater/component'

class MethodDoc
  include Clearwater::Component

  attr_reader :name, :description, :arguments, :return_value

  def initialize(name:, description: '', arguments: {}, return_value: nil, example: nil)
    @name = name
    @description = description
    @arguments = arguments
    @return_value = return_value
    @example = example
  end

  def render
    div({ style: { border_top: '1px solid rgba(0,0,0,0.1)', padding_bottom: '1em' } }, [
      h3({ id: id, style: { font_size: '1.4em' } }, a({ href: "##{id}" }, code(@name))),
      div(@description),
      unless @arguments.empty?
        [
          dl(@arguments.map { |name, description|
            [
              dt({ style: { font_weight: :bold } }, code(name)),
              dd(description),
            ]
          }),
        ]
      end,

      if @return_value
        div([
          strong('Returns: '),
          @return_value,
        ])
      end,

      if @example
        div({ id: "method-#{name}-example", class_name: 'method-example' }, [
          p(strong('Example')),
          @example,
        ])
      end,
    ])
  end

  def id
    "method-#{name.to_s[/^\W*\w+/].gsub(/\W+/, '-')}"
  end
end
