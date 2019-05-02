# Private class: See README.md for documentation.
class dcm4chee::params {

  $server = true
  $server_version = '2.18.1'
  $server_host = 'localhost'
  $server_java_path = undef
  $server_java_opts = []
  $server_http_port = '8080'
  $server_ajp_connector_port = '8009'
  # lint:ignore:single_quote_string_with_variables
  $server_log_file_path = '${jboss.server.log.dir}/server.log'
  # lint:endignore
  $server_log_file_max_size = '10000KB'
  $server_log_append = false
  $server_log_max_backups  = '1'
  $server_log_appenders  = [
    'FILE',
    'JMX',
  ]
  $server_dicom_aet = 'DCM4CHEE'
  $server_dicom_port = '11112'
  $server_dicom_compression = false
  $server_service_ensure = 'running'
  $server_service_enable = true
  $manage_user = true
  $user = 'dcm4chee'
  $user_home = '/opt/dcm4chee/'
  $staging_path = '/opt/dcm4chee/staging/'
  $database = true
  $database_type = 'postgresql'
  $database_host = 'localhost'
  $database_port = undef
  $database_name = 'pacsdb'
  $database_owner_password = 'dcm4chee'
  $weasis = true
  $weasis_aet = 'PACS-CONNECTOR'
  $weasis_request_addparams = undef
  $weasis_request_ids = [
    'patientID',
    'studyUID',
    'accessionNumber',
    'seriesUID',
    'objectUID',
  ]
  $weasis_hosts_allow = []

  if !($::operatingsystem == 'Ubuntu' and $::operatingsystemrelease == '16.04'
  and $::architecture == 'amd64') {
    fail('Module only supports Ubuntu 16.04 64bit')
  }
}
