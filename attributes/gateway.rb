# Where to write the mongodb service gateway's pid.
default['cloudfoundry_mongodb_service']['gateway']['pid_file'] = File.join(node['cloudfoundry']['pid_dir'], "mongodb_gateway.pid")

# Where to write the mongodb service gateway's logs.
default['cloudfoundry_mongodb_service']['gateway']['log_file'] = File.join(node['cloudfoundry']['log_dir'], "mongodb_gateway.log")

# Log level for the msyql service gateway.
default['cloudfoundry_mongodb_service']['gateway']['log_level'] = "info"

# TODO (trotter): Find out what this does.
default['cloudfoundry_mongodb_service']['gateway']['node_timeout'] = 30

# TODO (andreacampi): Find out what this does.
default['cloudfoundry_mongodb_service']['gateway']['timeout'] = 15