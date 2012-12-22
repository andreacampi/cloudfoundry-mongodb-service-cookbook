require File.expand_path('../support/helpers', __FILE__)

require 'sqlite3'

describe 'cloudfoundry-mongodb-service::node' do
  include Helpers::CFServiceMongoDB

  before do
    # Give the service some time to start up.
    sleep 10
  end

  it 'creates a instances dir' do
    directory('/var/vcap/services/mongodb/instances').must_exist.with(:owner, 'cloudfoundry')
  end

  it 'creates a database' do
    file('/var/vcap/services/mongodb/mongodb_node.db').must_exist.with(:owner, 'cloudfoundry')
  end

  it 'creates a config file with the expected content' do
    config = YAML.load_file('/etc/cloudfoundry/mongodb_node.yml')
    {
      "capacity" => 200,
      "plan" => "free",
      "local_db" => "sqlite3:/var/vcap/services/mongodb/mongodb_node.db",
      "mbus" => "nats://nats:nats@localhost:4222/",
      "index" => 0,
      "base_dir" => "/var/vcap/services/mongodb/instances",
      "mongod_log_dir" => "/var/log/cloudfoundry/mongodb",
      "pid" => "/var/run/cloudfoundry/mongodb_node.pid",
      "node_id" => "mongodb_node_0",
      "op_time_limit" => 6,
      "supported_versions" => ["2.2"],
      "default_version" => "2.2",
      "mongod_path" => {
        "2.2" => "/usr/bin/mongod"
      },
      "mongorestore_path" => {
        "2.2" => "/usr/bin/mongorestore"
      },
      "mongod_options" => {
        "2.2" => ""
      },
      "port_range" => {
        "first" => 25001,
        "last" => 45000
      },
      "migration_nfs" => "/mnt/migration",
      "logging" => {
        "level" => "info",
        "file" => "/var/log/cloudfoundry/mongodb_node.log"
      }
    }.each do |k,v|
      config[k].must_equal v
    end
  end

  it 'has no provisioned services' do
    db = sqlite('/var/vcap/services/mongodb/mongodb_node.db')
    rows = db.execute("select * from vcap_services_mongo_db_node_provisioned_services")
    rows.must_equal []
  end

protected
  def sqlite(path)
    @sqlite ||= SQLite3::Database.new(path)
  end
end
