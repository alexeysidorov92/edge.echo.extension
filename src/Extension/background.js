var portFromCS;

function connected(p) {
  portFromCS = p;
  portFromCS.onMessage.addListener(function(m) {
    console.log("In background script, received message from content script")
    console.log(m.greeting);

    var message = m.greeting === "hello from content script" ? "hello from background script" : m.greeting;
    portFromCS.postMessage({greeting: message.toUpperCase()});
  });
}

browser.runtime.onConnect.addListener(connected);