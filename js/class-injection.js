(function(exports, window){

var DOCUMENT = window.document;
var INJECTED = '-x-injected';

exports.injectClasses = injectClasses;

function injectClasses(data, rootNode) {
  var selector, classes, i;
  if (data == null) {
    data = window['INJECTION_CLASSES'];
  }
  if (rootNode == null) {
    rootNode = DOCUMENT;
  }
  if (data != null) {
    for (i = 0; i < data.length; ++i) {
      selector = data[i][0];
      classes = data[i][1];
      injectToNodes(selector, classes, rootNode);
    }
  }
}

function injectToNodes(selector, classes, rootNode) {
  var nodes, i;
  nodes = rootNode.querySelectorAll(selector);
  for (i = 0; i < nodes.length; ++i) {
    injectToNode(nodes[i], classes);
  }
}

function injectToNode(node, classes) {
  var i, c;
  if (node == null) {
    return;
  }
  if (classes == null) {
    return;
  } else if (classes.constructor === window.Object) {
    inject(node, classes);
  } else {
    add(node.classList, classes);
  }
  node.classList.add(INJECTED);
}

function add(classList, value) {
  if (value == null) {
    return;
  } else if (value.constructor === window.Array) {
    classList.add.apply(classList, value);
  } else {
    classList.add(value.toString());
  }
}

function inject(node, value) {
  if (value['parent'] != true) {
    injectToNode(node.parentNode, value['parent']);
  }
  if (value['add'] != null) {
    add(node.classList, value['add']);
  }
}

})(this, this);
