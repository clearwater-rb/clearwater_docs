require 'bundler/setup'
require 'opal'
require 'sprockets'
require 'clearwater'
require 'clearmarked'
require 'roda/opal_assets'

desc 'Compile assets'
task 'assets:precompile' do
  assets = Roda::OpalAssets.new(env: :production)
  assets << 'app.js' << 'default.css'
  assets.build
end
