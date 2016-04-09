ChildProcess = require 'child_process'
File = require 'fs'

module.exports =
class SauceConnect
  @launch: (user, api_key, options, callback) ->
    if typeof options == 'function'
      [options, callback] = [{}, options]
    jarfile = File.realpathSync("#{__dirname}/../ext/Sauce-Connect.jar")
    args = ['-jar', jarfile, user, api_key]
    for k, v of options
      if k.length == 1
        args.push "-#{k}"
      else
        args.push "--#{k}"
      if v
        args.push "#{v}"

    child = ChildProcess.spawn 'java', args
    child.stdout.on 'data', _on_data = (data) ->
      data = "#{data}"
      process.stdout.write(data)
      if data.match /Connected! You may start your tests/
        callback?()
    
    child.stderr.on 'data', _on_data

