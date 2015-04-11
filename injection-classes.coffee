---
---
@INJECTION_CLASSES = [

  [ 'nav', ['orange'] ]
  [ 'nav > *', ['nav-wrapper', 'container'] ]
  [ 'nav .title', 'brand-logo' ]
  [ '.main', 'container' ]
  [ 'footer', ['page-footer', 'orange'] ]
  [ 'footer > *', 'container' ]

  [ '#formlist', ['collapsible', 'popout'] ]
  [ '#form-appinfo > *:first-child', 'active' ]
  [ '#form-appinfo > *:first-child > i.icon', 'mdi-action-lock' ]
  [ '#form-admin > *:first-child > i.icon', 'mdi-hardware-security' ]
  [ '#form-user > *:first-child > i.icon', 'mdi-action-account-box' ]
  [ '#form-object > *:first-child > i.icon', 'mdi-action-description' ]
  [ '#form-curl_command', 'card' ]

  [ '#site-selector', 'row' ]
  [ '#site-selector > *', ['col', 's2'] ]
  [ '#form-app-id-and-key', 'row' ]
  [ '#form-app-id-and-key > *', ['col', 's6'] ]
  [ '#form-curl_command .title', ['card-title', 'orange-text'] ]

  [ '.group', 'section' ]

  [ '.collapsible > * > *:nth-child(1)', 'collapsible-header' ]
  [ '.collapsible > * > *:nth-child(2)', 'collapsible-body' ]
  [ 'input[type="text"] + label', {parent: 'input-field'} ]
  [ 'textarea', 'materialize-textarea' ]
  [ '.card > *', 'card-content' ]
  [ 'button', ['waves-effect', 'waves-light', 'btn'] ]

]
