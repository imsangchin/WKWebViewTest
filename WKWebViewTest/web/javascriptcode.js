window.androidObj = function AndroidClass() {};

var textContainer = document.createElement("p");
var nativeText = document.createTextNode("Android Text");
textContainer.appendChild(nativeText);

var inputContainer = document.createElement("p");
var input = document.createElement("INPUT");
input.setAttribute("type", "text");
inputContainer.appendChild(input);

var buttonContainer = document.createElement("p");
var button = document.createElement("button");
button.innerHTML = "Send to iOS";
button.style.width = "150px";
button.style.height = "30px";
button.addEventListener("click", function() {
    if (window.android)
       window.android.updateKeyword(input.value);
    else if (webkit)
       webkit.messageHandlers.callbackHandler.postMessage(input.value);
});
buttonContainer.appendChild(button);

document.body.appendChild(textContainer);
document.body.appendChild(inputContainer);
document.body.appendChild(buttonContainer);

function changeKeyword(message) {
    nativeText.nodeValue = message;
}
