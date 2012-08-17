# Log level for the msyql service gateway.
default['cloudfoundry_mongodb_service']['gateway']['log_level'] = "info"

# TODO (trotter): Find out what this does.
default['cloudfoundry_mongodb_service']['gateway']['node_timeout'] = 30

# TODO (andreacampi): Find out what this does.
default['cloudfoundry_mongodb_service']['gateway']['timeout'] = 15