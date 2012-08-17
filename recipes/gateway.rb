cloudfoundry_service_component "mongodb_gateway" do
  service_name  "mongodb"
  action        [:create, :enable]
end
