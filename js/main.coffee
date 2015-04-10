---
---
class Storage
  @TARGETS = [
    'app.site'
    'app.custom_site'
    'app.id'
    'app.key'
    'app.client_id'
    'app.client_secret'
    'user.name'
    'user.password'
  ]

  @toString: (s) ->
    return if s? then s else ''

  read: (view) ->
    if sessionStorage?
      data = {}
      for id in Storage.TARGETS
        data[id] = Storage.toString sessionStorage.getItem id
      view.set(data)
    return

  save: (view) ->
    if sessionStorage?
      for id in Storage.TARGETS
        sessionStorage.setItem id, Storage.toString view.get id
    return


View = Ractive.extend {
  template: '#app_template'
  generator: null
  storage: null

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
    @load()

  generate: (cmd) ->
    @generator?.generate @, cmd
    @save()

  save: ()->
    @storage?.save @

  load: ()->
    @storage?.read @
}


new View {
  el: '#app_container'
  generator: new Generator()
  storage: new Storage()
  data: {}
}
