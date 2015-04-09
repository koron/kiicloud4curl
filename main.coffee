---
---
View = Ractive.extend {
  template: '#app_template'
  generator: null

  init: () ->
    c = new ZeroClipboard @find '#curl_copy_to_clipboard'
    c.on 'ready', (event) =>
      c.on 'copy', (event) =>
        d = event.clipboardData
        d.setData 'text/plain', @get 'curl.command'
        return
      return
    c.on 'error', (event) ->
      ZeroClipboard.destroy()
      return

  generate: (cmd) ->
    @generator.generate @, cmd
}


new View {
  el: '#app_container'
  generator: new Generator()
  data: {}
}
