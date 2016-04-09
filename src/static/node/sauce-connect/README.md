node-sauce-connect
==================

This module is a simple wrapper around the SauceConnect.jar program available from SauceLabs.

````
SauceConnect = require 'sauce-connect'

SauceConnect.launch 'wavii', 'abcd1234-1234-abcd-a123-000000000000', ->
  console.log "READY TO START TESTS"
````

