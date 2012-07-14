{exec} = require 'child_process'
async = require 'async'

findExecutable = (executable, callback = console.log) ->
  exec "test `which #{executable}` || echo 'Missing #{executable}'", callback

build = (callback = console.log) ->
  async.series [
    (done) -> removeJS done
    (done) -> exec 'mkdir -p lib', done
    (done) -> exec "coffee --compile --output lib/ src/", done
  ], callback

removeJS = (callback = console.log) ->
  exec 'rm -fr lib/', callback

checkDependencies = (dependencies, callback = console.log) ->
  dependencies = dependencies.map (dep) ->
    (done) -> findExecutable dep, done
  async.parallel dependencies, callback

test = (callback = console.log) ->
  async.series [
    (done) -> checkDependencies ['vows', 'coffee'], done
    (done) -> build done
    (done) -> exec "vows --spec test/*"
  ]

publish = (callback = console.log) ->
  async.series [
    (done) -> build done
    (done) -> findExecutable 'npm', done
    (done) -> exec 'npm publish', done
  ]

dev_install = (callback = console.log) ->
  async.series [
    build
    findExecutable 'npm', done
    exec 'npm link .', done
  ], callback

log = (err) ->
  console.log err if err

task 'build', 'Build lib from src', -> build log
task 'test', 'Test project', -> test()
task 'cleanup', 'Clean lib folder', -> removeJS log
task 'publish', 'Publish project to npm', -> publish log
task 'dev-install', 'Install developer dependencies', -> dev_install log