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

  restore: (view) ->
    if sessionStorage?
      data = {}
      for id in Storage.TARGETS
        data[id] = Storage.toString sessionStorage.getItem id
      view.set data
    return

  save: (view, target) ->
    if sessionStorage?
      for id in Storage.TARGETS
        @update view, id
    return

  update: (view, id) ->
    if sessionStorage? and id?
      sessionStorage.setItem id, Storage.toString view.get id
    return

  installObserver: (view) ->
    observer = (nv, ov, path) =>
      @update view, path
    for id in Storage.TARGETS
      view.observe id, observer, {
        init: false
        defer: true
      }
    return


View = Ractive.extend {
  template: '#app_template'
  generator: null
  storage: null

  onrender: () ->
    injectClasses null, this.el
    # Install ZeroClipboard
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
    if @storage?
      @storage.restore @
      @storage.installObserver @
    return

  generate: (cmd) ->
    @generator?.generate @, cmd
    @storage?.save @
}


@V = new View {
  el: '#app_container'
  generator: @G = new Generator()
  storage: @S = new Storage()
  data: @D = {}
}
