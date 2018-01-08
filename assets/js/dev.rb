require 'opal'
require 'clearwater/hot_loader'
require 'app'

Clearwater::HotLoader.connect

Bowser.window.on(:resize) { Clearwater::Application.render }
