cloudfoundry_source "mongodb" do
  path          File.join(node['cloudfoundry']['vcap_services']['install_path'], "mongodb")
  repository    node['cloudfoundry']['vcap_services']['repo']
  reference     node['cloudfoundry']['vcap_services']['reference']
  subdirectory  "mongodb"
end
