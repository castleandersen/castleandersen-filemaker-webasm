# FileMaker WebAssembly WebView test

Simple test project to run WebAssembly function inside FileMaker WebView.

The `package.sh` sctipt builds the WebAssembly module and creates an Matryoshka Doll of nested base64 encoded WASM and JavaScript to load it as a proof-of-concept.

This documentation from [Wasm by Example](https://wasmbyexample.dev/examples/hello-world/hello-world.rust.en-us.html) can be helpful.

# Running the test

1. Run the `package.sh` script to build the WebAssembly module and create the HTML file.

![Alt text](doc/run.png?raw=true "Building")

2. Open the `FileMaker Primes.fmp12` FileMaker file in FileMaker Pro and paste in the contents of the `demo.html` file in to a WebView.

![Alt text](doc/filemaker.png?raw=true "Running in FileMaker")

