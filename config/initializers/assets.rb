Rails.application.config.assets.precompile += %w( chartkick.js )
Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'stylesheets', 'fonts')