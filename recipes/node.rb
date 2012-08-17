include_recipe "cloudfoundry-mongodb-service::source"
# include_recipe "mongodb::10gen_repo"

%w[sqlite3 libsqlite3-ruby libsqlite3-dev].each do |p|
  package p
end

%w[base_dir db_logs_dir instances_dir].each do |d|
  directory node['cloudfoundry_mongodb_service']['node'][d] do
    owner node['cloudfoundry']['user']
    mode  "0755"
  end
end

install_path = File.join(node['cloudfoundry_service']['install_path'], "mongodb")

cloudfoundry_component "mongodb_node" do
  install_path  File.join(install_path, "mongodb")
  bin_file      File.join(install_path, "mongodb", "bin", "mongodb_node")
  pid_file      node['cloudfoundry_mongodb_service']['node']['pid_file']
  log_file      node['cloudfoundry_mongodb_service']['node']['log_file']
  action        [:create, :enable]
  subscribes    :restart, resources(:cloudfoundry_service_install => "mongodb")
end
