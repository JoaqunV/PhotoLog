# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( variant1-blue.css )
Rails.application.config.assets.precompile += %w( variant2-green.css )
Rails.application.config.assets.precompile += %w( variant3-red.css )
Rails.application.config.assets.precompile += %w( variant4-bw.css )
Rails.application.config.assets.precompile += %w( variant5-yellow.css )

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
