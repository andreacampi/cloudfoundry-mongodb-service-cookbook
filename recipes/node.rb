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

cloudfoundry_service_component "mongodb_node" do
  service_name  "mongodb"
  action        [:create, :enable]
end
