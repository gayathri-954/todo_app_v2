# config/importmap.rb

# Main entrypoint
pin "application"

# Turbo (for SPA-like navigation in Rails 8)
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true

# Stimulus (optional, if you want to use controllers later)
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true

# Rails UJS (needed for link_to ..., method: :delete)
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.1.3/lib/assets/compiled/rails-ujs.js"
