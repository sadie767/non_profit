require('sinatra')
require('sinatra/reloader')
require('./lib/volunteer')
require('./lib/project')
also_reload('lib/**/*.rb')
require("pg")

# DB = PG.connect({:dbname => "patient"})
# DB = PG.connect({:dbname => "patient_test"})
# DB = PG.connect({:dbname => "doctor"})
# DB = PG.connect({:dbname => "doctor_test"})
