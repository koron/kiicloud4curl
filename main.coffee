---
---
View = Ractive.extend {
  template: '#app_template'
  generator: null

  generate: (cmd) ->
    @generator.generate @, cmd
}


new View {
  el: '#app_container'
  generator: new Generator()
  data: {}
}
