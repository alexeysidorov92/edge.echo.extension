# edge.echo.extension
This extension is worked on page https://alexeysidorov92.github.io/edge_echo.html Content script connects to background script 
using *browser.runtime.connect* and sends a message via *browser.runtime.Port* object when "Submit" button is clicked. Background script receives the messsage, converts
it to upper case and sends back. Then content script receives the modified message and displays it on the page.

Use build.bat to build extension package. You can specify following parameters:
* **-source_dir** extension source directory (default: *./src*)
* **-dest_dir** destionation directory (default: *./*)
* **-package_name** package name (default: *edge.echo.appx*)
* **-certificate** certificate to sign package (default: *./temporary.pfx*)
