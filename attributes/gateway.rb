#
# Cookbook Name:: cloudfoundry-mongodb-service
# Attributes:: gateway
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

# Log level for the msyql service gateway.
default['cloudfoundry_mongodb_service']['gateway']['log_level'] = "info"

# TODO (trotter): Find out what this does.
default['cloudfoundry_mongodb_service']['gateway']['node_timeout'] = 30

# TODO (andreacampi): Find out what this does.
default['cloudfoundry_mongodb_service']['gateway']['timeout'] = 15