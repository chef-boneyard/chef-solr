class Chef
  class Solr
    VERSION = '11.0.0.alpha'

    # Solr Schema. Used to detect incompatibilities between installed solr and
    # chef-solr versions.
    SCHEMA_NAME = "chef"
    SCHEMA_VERSION = '1.2'

  end
end
