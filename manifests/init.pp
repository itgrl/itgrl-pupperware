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
# The port of the Postgres host to use when performing initial health checks and when connecting to the database. Defaults to '5432'.
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
# How long nodes should be preserved in puppetdb without receiving any updates (new catalogs, facts, or reports) before
# being marked expired. Defaults to '7d'.
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
# Subject Alternative Names to be included on the SSL certificate. Defaults to empty string. Note the Puppet CA must
# be configured to allow Subject Alternative Names, by default it rejects them.
#
## @example
#   include pupperware
class pupperware (
  $dns_servers,
  Enum['run', 'compose'] $docker_type,
  Boolean                $pupperware_analytics_enabled,
  String                 $puppetserver_java_args,
  Integer                $puppetserver_max_active_instances,
  Integer                $puppetserver_max_requests_per_instance,
  Boolean                $ca_enabled,
  String                 $ca_hostname,
  String                 $ca_masterport,
  Boolean                $ca_allow_subject_alt_names,
  Boolean                $puppetserver_consul_enabled,
  String                 $puppetserver_consul_hostname,
  String                 $puppetserver_consul_port,
  String                 $puppetserver_network_interface,
  Boolean                $puppet_reports,
  Boolean                $puppet_storeconfigs,
  Boolean                $puppet_storeconfigs_backend,
  Array[String]          $puppetdb_server_urls,
  String                 $puppetserver_hostname,
  String                 $puppetserver_port,
  Boolean                $autosign,
  String                 $dns_alt_names,
  Boolean                $use_puppetdb,
  Boolean                $use_puppetserver,
  String                 $puppetdb_postgres_hostname,
  String                 $puppetdb_postgres_port,
  String                 $puppetdb_user,
  String                 $puppetdb_password,
  String                 $puppetdb_node_ttl,
  String                 $puppetdb_node_purge_ttl,
  String                 $puppetdb_report_ttl,
  String                 $puppetdb_java_args,
  String                 $puppetdb_consul_enabled,
  String                 $puppetdb_consul_hostname,
  String                 $puppetdb_consul_port,
  String                 $puppetdb_network_interface,
  String                 $postgres_password,
  String                 $postgres_user,
  String                 $postgres_db,
  String                 $postgres_initdb_args,
  String                 $postgres_initdb_waldir,
  String                 $postgres_host_auth_method,
  String                 $pgdata,
  String                 $puppet_masterport = '8140',
  String                 $docker_compose_file = '/tmp/docker-compose.yml',
  String                 $compose_file_owner = 'root',
  String                 $compose_file_group = 'root',
  String                 $compose_file_mode  = '0644',
  String                 $compose_file_version = '3.7',
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
