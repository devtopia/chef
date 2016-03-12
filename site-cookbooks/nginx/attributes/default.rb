default['nginx']['version'] = '1.8.1'
default['nginx']['url'] = "http://nginx.org/download/nginx-#{default['nginx']['version']}.tar.gz"
default['nginx']['prefix'] = "/opt/nginx-#{default['nginx']['version']}"
default['nginx']['sbin'] = "#{default['nginx']['prefix']}/sbin/nginx"
default['nginx']['dir'] = '/etc/nginx'
default['nginx']['user'] = 'neowiz'
default['nginx']['port'] = '80'
default['nginx']['worker_processes'] = 1
default['nginx']['keepalive_requests'] = 100
default['nginx']['keepalive_timeout'] = 1
default['nginx']['whitelist'] = %w(
	203.141.243
	122.208.116
	10.51.17
	10.0.30
	10.0.40
	10.0.50
	10.0.60
	58.150.56.51
	58.150.56.24
	58.150.56.94
	27.147.96.130
	203.174.65.44
	59.128.12.74
).join('|')
default['nginx']['modules'] = %w(
  --with-http_ssl_module
  --with-http_stub_status_module
  --with-http_gzip_static_module
  --with-http_flv_module
  --with-http_mp4_module
).join(' ')
