#
# Cookbook Name:: wordpress
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

wordpress_url = node['wordpress']['url']
wordpress_name = node['wordpress']['name']
wordpress_filename = wordpress_url.split("/").last
src_filepath  = "#{Chef::Config['file_cache_path'] || '/tmp'}/#{wordpress_filename}"

remote_file wordpress_url do
  source wordpress_url
  path src_filepath
  backup false
end

bash "install #{wordpress_name}" do
  cwd File.dirname(src_filepath)
  code <<-EOH
    mkdir -p /var/www
    tar zxf #{wordpress_filename} -C /var/www
    chown #{node['nginx']['user']}:#{node['nginx']['group']} -R /var/www/#{wordpress_name}
  EOH
  not_if { File.exists?("/var/www/#{wordpress_name}") }
end

cookbook_file "/var/www/#{wordpress_name}/wp-content/plugins/got_rewrite.php" do
  source 'got_rewrite.php'
  owner node['nginx']['user']
  group node['nginx']['group']
  mode '0644'
  not_if { File.exists?("/var/www/#{wordpress_name}/wp-content/plugins/got_rewrite.php") }
end

bash "create database to use #{wordpress_name}" do
  cwd File.dirname(src_filepath)
  code <<-EOH
    mysqladmin -uroot create #{wordpress_name}
    mysql -uroot #{wordpress_name} -e '#{node['wordpress']['sql']}'
  EOH
  only_if "ps aux | grep mysqld | grep -v grep"
  not_if "mysqlshow -uroot | grep #{wordpress_name}"
end

template "/etc/nginx/sites-available/#{wordpress_name}" do
  source "#{wordpress_name}.erb"
  owner 'root'
  group 'root'
  mode '0644'
end

link "/etc/nginx/sites-enabled/#{wordpress_name}" do
  to "/etc/nginx/sites-available/#{wordpress_name}"
  notifies :reload, 'service[nginx]'
end
