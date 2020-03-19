# @summary PuppetDB container
#
# Sets configuration for `docker-compose` or `docker run` methods to start up the PuppetDB container. 
# @api private
#
class pupperware::puppetdb (
  $dns_servers = $::pupperware::dns_servers,
  $docker_type = $::pupperware::docker_type,
  $docker_compose_file = $::pupperware::docker_compose_file,
  $use_puppetdb = $::pupperware::use_puppetdb,
  $use_puppetserver = $::pupperware::use_puppetserver,
  $puppetdb_postgres_hostname = $::pupperware::puppetdb_postgres_hostname,
  $puppetdb_postgres_port = $::pupperware::puppetdb_postgres_port,
  $puppetdb_user = $::pupperware::puppetdb_user,
  $puppetdb_password = $::pupperware::puppetdb_password,
  $puppetdb_node_ttl = $::pupperware::puppetdb_node_ttl,
  $puppetdb_node_purge_ttl = $::pupperware::puppetdb_node_purge_ttl,
  $puppetdb_report_ttl = $::pupperware::puppetdb_report_ttl,
  $puppetdb_java_args = $::pupperware::puppetdb_java_args,
  $consul_enabled = $::pupperware::puppetdb_consul_enabled,
  $consul_hostname = $::pupperware::puppetdb_consul_hostname,
  $consul_port = $::pupperware::puppetdb_consul_port,
  $network_interface = $::pupperware::puppetdb_network_interface,
){

}
