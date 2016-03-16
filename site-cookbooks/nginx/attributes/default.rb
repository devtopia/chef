default['nginx']['ver'] = '1.8.1'
default['nginx']['url'] = "http://nginx.org/download/nginx-#{node['nginx']['ver']}.tar.gz"
default['nginx']['prefix'] = "/opt/nginx-#{node['nginx']['ver']}"
default['nginx']['sbin'] = "#{node['nginx']['prefix']}/sbin/nginx"
default['nginx']['dir'] = '/etc/nginx'
default['nginx']['user'] = 'neowiz'
default['nginx']['port'] = '80'
default['nginx']['worker_processes'] = 1
default['nginx']['keepalive_requests'] = 100
default['nginx']['keepalive_timeout'] = 1
default['nginx']['whitelist'] = %w(
  192.168.33.10
  192.168.33.11
).join('|')
default['nginx']['default_configure_flags'] = %W(
  --prefix=#{node['nginx']['prefix']}
  --conf-path=#{node['nginx']['dir']}/nginx.conf
  --sbin-path=#{node['nginx']['sbin']}
)
default['nginx']['modules'] = %w(
  --with-http_ssl_module
  --with-http_stub_status_module
  --with-http_gzip_static_module
  --with-http_flv_module
  --with-http_mp4_module
)
