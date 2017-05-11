require 'clearwater/component'

class MethodDoc
  include Clearwater::Component

  attr_reader :name, :description, :arguments, :return_value

  def initialize(name:, description: '', arguments: {}, return_value: nil)
    @name = name
    @description = description
    @arguments = arguments
    @return_value = return_value
  end

  def render
    div({ style: { border_top: '1px solid rgba(0,0,0,0.1)', padding_bottom: '1em' } }, [
      h3({ id: id, style: { font_size: '1.4em' } }, a({ href: "##{id}" }, code(@name))),
      div(@description),
      unless @arguments.empty?
        [
          # h5({ id: "#{id}-arguments"}, 'Arguments'),
          dl(@arguments.map { |name, description|
            [
              dt({ style: { font_weight: :bold } }, name),
              dd(description),
            ]
          }),
          # table([
          #   tbody(@arguments.map { |name, description|
          #     tr([
          #       th(name),
          #       td(description),
          #     ])
          #   }),
          # ]),
        ]
      end,
      if @return_value
        div([
          strong('Returns: '),
          @return_value,
        ])
      end,
    ])
  end

  def id
    "method-#{name.to_s[/^\W*\w+/].gsub(/\W+/, '-')}"
  end
end
