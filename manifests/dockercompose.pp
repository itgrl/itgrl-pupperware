# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include pupperware::dockercompose
class pupperware::dockercompose (
  String $compose_file = $::pupperware::docker_compose_file,
){
  include docker::compose

  docker_compose { "PuppetPlatform":
    ensure        => present,
    compose_files => [ $compose_file ],
  }
}
