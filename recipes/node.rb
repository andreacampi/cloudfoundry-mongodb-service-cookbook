#
# Cookbook Name:: cloudfoundry-mongodb-service
# Recipe:: node
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

node.default['cloudfoundry_mongodb_service']['node']['ruby_version'] = node['cloudfoundry']['ruby_1_9_2_version']
node.default['cloudfoundry_mongodb_service']['node']['base_dir'] = File.join(node['cloudfoundry_service']['base_dir'], "mongodb")
node.default['cloudfoundry_mongodb_service']['node']['db_logs_dir'] = File.join(node['cloudfoundry']['log_dir'], "mongodb")
node.default['cloudfoundry_mongodb_service']['node']['instances_dir'] = "#{node['cloudfoundry_mongodb_service']['node']['base_dir']}/instances"

ruby_ver = node['cloudfoundry_mongodb_service']['node']['ruby_version']
ruby_path = ruby_bin_path(ruby_ver)

include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

rbenv_ruby ruby_ver

# include_recipe "mongodb::10gen_repo"

%w[sqlite3 libsqlite3-ruby libsqlite3-dev].each do |p|
  package p
end

cloudfoundry_service_component "mongodb_node" do
  service_name  "mongodb"
  action        [:create, :enable]
end

%w[db_logs_dir instances_dir].each do |d|
  directory node['cloudfoundry_mongodb_service']['node'][d] do
    owner node['cloudfoundry']['user']
    mode  "0755"
  end
end
