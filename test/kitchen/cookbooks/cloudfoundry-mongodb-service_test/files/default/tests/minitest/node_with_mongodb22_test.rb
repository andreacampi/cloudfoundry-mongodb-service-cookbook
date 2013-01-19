require File.expand_path('../support/helpers', __FILE__)

require 'sqlite3'

describe 'cloudfoundry-mongodb-service::node' do
  include Helpers::CFServiceMongoDBTest

  it 'checks out sources with the correct permissions' do
    dirs = [
      '/srv/cloudfoundry/services/mongodb_node',
      '/srv/cloudfoundry/services/mongodb_node/mongodb',
      '/srv/cloudfoundry/services/mongodb_node/mongodb/bundle',
      '/srv/cloudfoundry/services/mongodb_node/mongodb/.bundle'
    ]
    dirs.each do |d|
      directory(d).must_exist.with(:owner, 'cloudfoundry') # .with(:group, 'cloudfoundry')
    end
  end

  it 'creates a config file with the correct permissions' do
    files = [
      '/etc/cloudfoundry/mongodb_node.yml'
    ]
    files.each do |f|
      file(f).must_exist.with(:owner, 'cloudfoundry') # .with(:group, 'cloudfoundry')
    end
  end

  it 'creates a instances dir' do
    directory('/var/vcap/services/mongodb/instances').must_exist.
      with(:owner, 'cloudfoundry').
      with(:group, 'cloudfoundry')
  end

  it 'creates a database' do
    sleep 20 # Give the service some time to start up.
    file('/var/vcap/services/mongodb/mongodb_node.db').must_exist.
      with(:owner, 'cloudfoundry').
      with(:group, 'cloudfoundry')
  end

  it 'creates a valid config file' do
    YAML.load_file('/etc/cloudfoundry/mongodb_node.yml')
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

    config.has_key?('ip_route').must_equal false
  end

  it 'has no provisioned services' do
    db = sqlite('/var/vcap/services/mongodb/mongodb_node.db')
    rows = db.execute("select * from vcap_services_mongo_db_node_provisioned_services")
    rows.must_equal []
  end

protected
  def sqlite(path)
    @sqlite ||= begin
      sleep 20 # Give the service some time to start up.
      file(path).must_exist # do not create the DB if it doesn't exist
      SQLite3::Database.new(path)
    end
  end
end
