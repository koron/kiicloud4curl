---
---
SITE = {
  us: 'https://api.kii.com/api'
  jp: 'https://api-jp.kii.com/api'
  cn: 'https://api-cn2.kii.com/api'
  sg: 'https://api-sg.kii.com/api'
}


class @Generator
  site: (view) ->
    return SITE[view.get('app.site')]

  path: (view, path) ->
    s = @site view
    return if s? then s + path else null

  headerApp: (view, userdata) ->
    id = view.get('app.id')
    key = view.get('app.key')
    if id == '' or key == ''
      return null
    return {
      'X-Kii-AppID': id
      'X-Kii-AppKey': key
    }

  setCurlCommand: (view, cmd) ->
    view.set 'curl.command', cmd.join ' '

  buildCurlCommand: (url, header, data) ->
    cmd = ['curl']
    cmd.push '-X', 'POST'
    if header?
      for n, v of header
        cmd.push '-H', "\"#{n}=#{v}\""
    if data?
      cmd.push '-d', "'#{JSON.stringify data}'"
    cmd.push url
    return cmd

  generate: (view, cmd) ->
    switch cmd
      when 'admin-token' then @gen_adminToken view
      when 'user-login' then @gen_userLogin view
      else console.log 'unknown command: ' + cmd

  gen_adminToken: (view) ->
    url = @path view, '/oauth2/token'
    header = @headerApp view, {}
    cmd = @buildCurlCommand url, header, {
      client_id: view.get 'app.client_id'
      client_key: view.get 'app.client_secret'
    }
    @setCurlCommand view, cmd

  gen_userLogin: (view) ->
    url = @path view, '/oauth2/token'
    header = @headerApp view, {}
    cmd = @buildCurlCommand url, header, {
      username: view.get 'user.name'
      password: view.get 'user.password'
    }
    @setCurlCommand view, cmd
