(function(window) {

var undef = (void 0);

var View = Ractive.extend({
  template: '#app_template',
  generate: function(cmd) {
    generate(this, cmd);
  },

  site: function() {
    return SITE[this.get('app.site')];
  },

  path: function(path) {
    var s = this.site();
    if (s === undef) {
      return undef;
    }
    return s + path;
  },

  headerApp: function(userdata) {
    var id = this.get('app.id');
    var key = this.get('app.key');
    if (id == '' || key == '') {
      return undef;
    }
    // TODO: merge with userdata.
    return {
      'X-Kii-AppID': id,
      'X-Kii-AppKey': key
    }
  },

  setCurlCommand: function(v) {
    this.set('curl.command', v);
  }
});

new View({
  el: '#app_container',
  data: {
    app: {
      site: '',
      id: '',
      key: '',
      client_id: '',
      client_secret: ''
    },
    user: {
      name: '',
      password: ''
    },
    curl: {
      command: ''
    }
  }
});

function generate(r, cmd) {
  switch (cmd) {
    case 'admin-token':
      gen_adminToken(r);
      break;
    case 'user-login':
      gen_userLogin(r);
      break;
    default:
      console.warn('unknown command: ' + cmd);
      break;
  }
}

var SITE = {
  us: 'https://api.kii.com/api',
  jp: 'https://api-jp.kii.com/api',
  cn: 'https://api-cn2.kii.com/api',
  sg: 'https://api-sg.kii.com/api'
}

function curlCommand(url, header, data) {
  var c = ['curl'];
  c.push('-X', 'POST');
  if (header !== undef) {
    for (var n in header) {
      c.push('-H', '"' + n + '=' + header[n] + '"');
    }
  }
  if (data !== undef) {
    c.push('-d', "'" + JSON.stringify(data) + "'");
  }
  c.push(url);
  return c.join(' ');
}

function gen_adminToken(r) {
  var u = r.path('/oauth2/token');
  var h = r.headerApp();
  if (u === undef || h === undef) {
    return;
  }
  var c = curlCommand(u, h, {
    client_id: r.get('app.client_id'),
    client_secret: r.get('app.client_secret')
  });
  r.setCurlCommand(c);
}

function gen_userLogin(r) {
  var u = r.path('/oauth2/token');
  var h = r.headerApp();
  if (u === undef || h === undef) {
    return;
  }
  var c = curlCommand(u, h, {
    username: r.get('user.name'),
    password: r.get('user.password')
  });
  r.setCurlCommand(c);
}

})(this);
