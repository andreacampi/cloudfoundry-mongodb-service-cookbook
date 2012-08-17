#
# Cookbook Name:: cloudfoundry-mongodb-service
# Attributes:: default
#
# Copyright 2012, ZephirWorks
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

# Where to write the mongodb service node's logs.
default['cloudfoundry_mongodb_service']['node']['db_logs_dir'] = File.join(node['cloudfoundry']['log_dir'], "mongodb")

# Base directory for instance-specific data
default['cloudfoundry_mongodb_service']['node']['base_dir'] = File.join(node['cloudfoundry']['services_dir'], "mongodb")

# Log level for the msyql service node.
default['cloudfoundry_mongodb_service']['node']['log_level'] = "info"

# Unique instance index.
default['cloudfoundry_mongodb_service']['node']['index'] = 0

# Maximum number of service instances for this node.
default['cloudfoundry_mongodb_service']['node']['capacity'] = 200

# Where to store the database for each instance.
default['cloudfoundry_mongodb_service']['node']['instances_dir'] = "#{node['cloudfoundry_mongodb_service']['node']['base_dir']}/instances"

default['cloudfoundry_mongodb_service']['node']['port_range']['first'] = 25001
default['cloudfoundry_mongodb_service']['node']['port_range']['last'] = 45000

# TODO (trotter): Find out what this does.
default['cloudfoundry_mongodb_service']['node']['migration_nfs'] = "/mnt/migration"

# TODO (trotter): Find out what this does.
default['cloudfoundry_mongodb_service']['node']['op_time_limit'] = 6


default['cloudfoundry_mongodb_service']['node']['versions'] = {
  "1.8" => {
    "mongod_base_path" => "/usr",
    "mongod_options" => ""
  },
  "2.0" => {
    "mongod_base_path" => "/usr", # FIXME
    "mongod_options" => "--nojournal"
  }
}

default['cloudfoundry_mongodb_service']['node']['default_version'] = "1.8"
