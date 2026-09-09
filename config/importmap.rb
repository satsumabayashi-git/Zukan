# Pin npm packages by running ./bin/importmap

pin "application"

pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

# pin "jquery" # @3.7.1
# pin "popper.js" # @1.16.1

# pin "chartkick", to: "chartkick.js"
# pin "Chart.bundle", to: "Chart.bundle.js"

# pin "bootstrap" # @5.3.8
# pin "@popperjs/core", to: "@popperjs--core.js" # @2.11.8


pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true

# pin_all_from 'app/javascript/files', under: 'files'
# pin "test", to: "test.js"

