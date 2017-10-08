desc "Start up combined Rails API and React Client"
task :start do
  exec "foreman start -p 3000"
end
