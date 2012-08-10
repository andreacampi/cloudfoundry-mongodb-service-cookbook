include_recipe "cloudfoundry-mongodb-service::source"

install_path = File.join(node['cloudfoundry']['vcap_services']['install_path'], "mongodb")

cloudfoundry_component "mongodb_gateway" do
  install_path  File.join(install_path, "mongodb")
  bin_file      File.join(install_path, "mongodb", "bin", "mongodb_gateway")
  pid_file      node['cloudfoundry_mongodb_service']['gateway']['pid_file']
  log_file      node['cloudfoundry_mongodb_service']['gateway']['log_file']
  action        [:create, :enable]
  subscribes    :restart, resources(:cloudfoundry_source => "mongodb")
end
