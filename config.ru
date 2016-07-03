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
    <title>Clearwater — Awesome stuff</title>
    #{assets.stylesheet 'default'}
  </head>
  <body>
    #{assets.js 'app'}
  </body>
</html>
    HTML
  end
end

run ClearwaterDocs
