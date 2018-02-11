require 'bundler/setup'
Bundler.require

class ClearwaterDocs < Roda
  entry_point_expiration = 60 * 60 * 24 # cache entry points for a day
  static_expiration = entry_point_expiration * 365 # cache static assets for longer

  plugin :public, headers: {
    'Cache-Control' => "public, max-age=#{static_expiration}"
  }

  assets = Roda::OpalAssets.new

  route do |r|
    r.public

    assets.route r

    response.headers['Cache-Control'] = "public, max-age=#{entry_point_expiration}"
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
