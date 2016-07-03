require 'bundler/setup'
Bundler.require

class ClearwaterDocs < Roda
  assets = Roda::OpalAssets.new

  route do |r|
    assets.route r

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
    #{assets.js 'app'}
  </body>
</html>
    HTML
  end
end

use Rack::Deflater
run ClearwaterDocs
