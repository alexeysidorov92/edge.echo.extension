var myPort = browser.runtime.connect({name:"port-from-cs"});
myPort.postMessage({greeting: "hello from content script"});

myPort.onMessage.addListener(function(m) {
  console.log("In content script, received message from background script: ");
  console.log(m.greeting);
  document.getElementById("MessageOutput").value = m.greeting;
});

myPort.onDisconnect.addListener(function() {
  document.getElementById("MessageOutput").value = "DISCONNECTED";
});

function sendMessage() {
  var message = document.getElementById("MessageInput").value;
  myPort.postMessage({greeting: message});
}

document.getElementById("SubmitButton").onclick = sendMessage;

