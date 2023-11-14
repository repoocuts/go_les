# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "flowbite", to: "https://cdnjs.cloudflare.com/ajax/libs/flowbite/1.7.0/flowbite.turbo.min.js", preload: true
pin "tailwindcss", to: 'app/assets/stylesheets/application.tailwind.css'
pin "chartkick", to: "chartkick.js"
pin "Chart.bundle", to: "Chart.bundle.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "highcharts" # @11.2.0
