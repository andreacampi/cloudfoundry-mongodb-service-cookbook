include_recipe "cloudfoundry-mongodb-service::install22"
include_recipe "cloudfoundry-mongodb-service_test::node"

node.default['cloudfoundry_mongodb_service']['node']['default_version'] = "2.2"

include_recipe "cloudfoundry-mongodb-service::node"
