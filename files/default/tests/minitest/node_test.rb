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
