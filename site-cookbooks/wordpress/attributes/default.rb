default['wordpress']['url'] = 'http://wordpress.org/latest.tar.gz'
default['wordpress']['name'] = 'wordpress' 
default['wordpress']['port'] = '80'
default['wordpress']['sql'] = <<-EOH
  grant all privileges on #{node['wordpress']['name']}.* to "#{node['wordpress']['name']}"@"localhost" identified by "hogehoge"
EOH
