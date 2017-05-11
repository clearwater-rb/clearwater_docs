require 'bundler/setup'
Bundler.require

class ClearwaterDocsDev < Roda
  assets = Roda::OpalAssets.new

  route do |r|
    assets.route r

    r.on 'clearwater_hot_loader' do
      r.run Clearwater::HotLoader
    end

    <<-HTML
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>Clearwater — A Ruby Front-end Framework</title>
    #{assets.stylesheet 'default'}
    <meta name="viewport" content="initial-scale=1,width=device-width" />
  </head>
  <body>
    #{assets.js 'dev'}
  </body>
</html>
    HTML
  end
end

Clearwater::HotLoader.start

use Rack::Deflater
run ClearwaterDocsDev
