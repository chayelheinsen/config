# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "jsoneditor", to: "https://ga.jspm.io/npm:jsoneditor@9.5.10/dist/jsoneditor.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
