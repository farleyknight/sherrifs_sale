
dbconfig = YAML::load(File.open('sqlite3.yml'))
ActiveRecord::Base.establish_connection(dbconfig)
