# pupperware 
#
# Main class, includes all other classes.
# 
# 
# 
# @param pupperware_analytics_enabled
#
# Set to 'true' to enable Google Analytics. Defaults to 'false'.
#
# @param puppetserver_container
#
# @param puppetdb_container
#
# @param postgres_container
#
# @param r10k_container
# 
# PuppetDB container parameters prefixed with (PDB)
#
# @param PDB_use_puppetserver
#
# Set to 'false' to skip acquiring SSL certificates from a Puppet Server. Defaults to 'true'.
#
# @param puppetdb_postgres_hostname
#
# The DNS name of the Postgres host to use when performing initial health checks and when 
# connecting to the database. Defaults to 'postgres'.
#
# @param puppetdb_postPUPPETDB_POSTGRES_PORT
#
# The port of the Postgres host to use when performing initial health checks and when connecting 
# to the database. Defaults to '5432'.
#
# @param puppetdb_postgres_database
#
# The database name in Postgres. Defaults to 'puppetdb'.
#
# @param puppetdb_user
#
# The user to connect to the postgres database as. Defaults to 'puppetdb'.
#
# @param puppetdb_password
#
# The password to connect to the postgres database with. Defaults to 'puppetdb'.
#
# @param puppetdb_node_ttl
#
# How long nodes should be preserved in puppetdb without receiving any updates (new catalogs, facts,i
# or reports) before being marked expired. Defaults to '7d'.
#
# @param puppetdb_node_purge_ttl
#
# Delete nodes that have been deactivated or expired for the specified amount of time. Defaults to '14d'.
#
# @param puppetdb_report_ttl
#
# Automatically delete reports that are older than the specified amount of time. Defaults to '14d'.
#
# @param puppetdb_java_args
#
# Additional Java args to pass to the puppetdb process. Defaults to '-Djava.net.preferIPv4Stack=true -Xms256m -Xmx256m'.
#
# @param consul_enabled
#
# Whether or not to register the puppet service with an external consul server. Defaults to 'false'.
#
# @param puppetdb_consul_hostname
#
# If consul is enabled, the hostname for the external consul server. Defaults to 'consul'.
#
# @param puppetdb_consul_port
#
# If consul is enabled, the port to access consul at. Defaults to '8500'.
#
# @param puppetdb_network_interface
#
# If consul is enabled the network interface to use when finding the server's IP. Defaults to 'eth0'
#
# puppetserver_hostname
#
# The hostname for the puppetserver instance. This determines where to request certificates from. Defaults to 'puppet'.
#
# @param puppetdb_puppetserver_port
#
# The port for the puppetserver instance. This determines where to request certificates from. Defaults to '8140'.
#
# @param puppetdb_dns_alt_names
#
# Subject Alternative Names to be included on the SSL certificate. Defaults to empty string. Note the Puppet CA must be 
# configured to allow Subject Alternative Names, by default it rejects them.
#
## @example
#   include pupperware
class pupperware (
  $docker_compose_file = '/tmp/docker-compose.yml',
  $compose_file_owner = 'root',
  $compose_file_group = 'root',
  $compose_file_mode  = '0644',
  $compose_file_version = '3.7',
  $puppet_masterport = '8140',
  Enum['run', 'compose'] $docker_type = 'compose',
  $pupperware_analytics_enabled,
  $puppetserver_java_args,
  $puppetserver_max_active_instances,
  $puppetserver_max_requests_per_instance,
  $ca_enabled,
  $ca_hostname,
  $ca_masterport,
  $ca_allow_subject_alt_names,
  $puppetserver_consul_enabled,
  $puppetserver_consul_hostname,
  $puppetserver_consul_port,
  $puppetserver_network_interface,
  $puppet_reports,
  $puppet_storeconfigs,
  $puppet_storeconfigs_backend,
  $puppetdb_server_urls,
  $puppetserver_hostname,
  $puppetserver_port,
  $autosign,
  $dns_alt_names,
  $use_puppetdb,
  $use_puppetserver,
  $puppetdb_postgres_hostname,
  $puppetdb_postgres_port,
  $puppetdb_user,
  $puppetdb_password,
  $puppetdb_node_ttl,
  $puppetdb_node_purge_ttl,
  $puppetdb_report_ttl,
  $puppetdb_java_args,
  $puppetdb_consul_enabled,
  $puppetdb_consul_hostname,
  $puppetdb_consul_port,
  $puppetdb_network_interface,
  $postgres_password,
  $postgres_user,
  $postgres_db,
  $postgres_initdb_args,
  $postgres_initdb_waldir,
  $postgres_host_auth_method,
  $pgdata,
  $dns_servers,
){
  # Create the concat of the Docker Compose file, if $docker_type = compose
  if $docker_type == 'compose' {
    concat { $docker_compose_file:
      owner => $compose_file_owner,
      group => $compose_file_group,
      mode  => $compose_file_mode,
    }

    concat::fragment { "${docker_compose_file} header":
      order   => '01',
      content => "version: '${compose_file_version}'\n\nservices:\n",
    }


  }

}
