#
# Cookbook Name:: cloudfoundry-mongodb-service
# Attributes:: node
#
# Copyright 2012, ZephirWorks
# Copyright 2012, Trotter Cashion
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Log level for the service node daemon.
default['cloudfoundry_mongodb_service']['node']['log_level'] = "info"

# Unique instance info; should be configured to be different between nodes.
default['cloudfoundry_mongodb_service']['node']['index'] = 0

# Maximum number of service instances for this node.
default['cloudfoundry_mongodb_service']['node']['capacity'] = 200

# The lower end of a range of ports that can be used for services nodes.
default['cloudfoundry_mongodb_service']['node']['port_range']['first'] = 25001

# The higher end of a range of ports that can be used for services nodes.
default['cloudfoundry_mongodb_service']['node']['port_range']['last'] = 45000

# Path to a directory that will be used when dumping and reimporting a node.
default['cloudfoundry_mongodb_service']['node']['migration_nfs'] = "/mnt/migration"

# Maximum time to wait during provisioning.
default['cloudfoundry_mongodb_service']['node']['op_time_limit'] = 6

# A Hash mapping versions of MongoDB to their runtime details.
default['cloudfoundry_mongodb_service']['node']['versions'] = {}

# The default version for requests to this node.
default['cloudfoundry_mongodb_service']['node']['default_version'] = "2.2"
