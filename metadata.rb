maintainer       "Trotter Cashion"
maintainer_email "cashion@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures cloudfoundry-mongodb-service"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.2"

%w( ubuntu ).each do |os|
  supports os
end

%w( cloudfoundry mongodb ).each do |cb|
  depends cb
end
depends "cloudfoundry_service", "~> 1.1.4"
