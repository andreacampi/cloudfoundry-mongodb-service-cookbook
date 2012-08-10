include_attribute "cloudfoundry"

default['cloudfoundry_mongodb_service']['supported_versions'] = {
        "1.8" => "1.8.5"
}
default['cloudfoundry_mongodb_service']['version_aliases'] = {
        "current" => "1.8"
}
