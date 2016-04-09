#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'nginx::ohai_plugin' 
nginx_url = node['nginx']['url']
nginx_filename = "nginx-#{node['nginx']['ver']}.tar.gz"
src_filepath  = "#{Chef::Config['file_cache_path'] || '/tmp'}/#{nginx_filename}"

%w(gcc gcc-c++ openssl-devel pcre pcre-devel).each do |pkg|
  package pkg do
    action :install
  end
end

remote_file nginx_url do
  source nginx_url
  path src_filepath
  backup false
end

user node['nginx']['user'] do
  comment "create user of nginx"
  system true
  shell '/bin/false'
end

directory "/var/log/nginx" do
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

directory "#{node['nginx']['dir']}" do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file "#{node['nginx']['dir']}/mime.types" do
  source 'mime.types'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :reload, 'service[nginx]'
end

cookbook_file "#{node['nginx']['dir']}/authorized_ip" do
  source 'authorized_ip'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :reload, 'service[nginx]'
end

template '/etc/sysconfig/nginx' do
  source 'nginx.sysconfig.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

%w(/etc/init.d/nginx /etc/rc.d/init.d/nginx).each do |src|
  template src do
    source 'nginx.init.erb'
    owner 'root'
    group 'root'
    mode '0755'
  end
end

%w(sites-available sites-enabled).each do |dir|
  directory "#{node['nginx']['dir']}/#{dir}" do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
end

force_recompile = false
configure_flags = node['nginx']['default_configure_flags'] | node['nginx']['modules']

bash "install nginx" do
  cwd File.dirname(src_filepath)
  code <<-EOH
    tar zxf #{nginx_filename} -C #{File.dirname(src_filepath)}
    cd #{File.dirname(src_filepath)}/#{File.basename(nginx_filename, ".tar.gz")}
    ./configure #{configure_flags.join(' ')}
    make
    make install
  EOH

  not_if do
    force_recompile == false &&
    node.automatic_attrs['nginx'] &&
    node.automatic_attrs['nginx']['version'] == node['nginx']['ver'] &&
    node.automatic_attrs['nginx']['configure_arguments'].sort == configure_flags.sort
  end

  notifies :restart, 'service[nginx]'
  notifies :reload,  'ohai[reload_nginx]', :immediately
end

execute 'add to the list using the chkconfig command' do
  command 'chkconfig --add nginx && chkconfig nginx on'
  not_if 'chkconfig --list nginx'
end

template "#{node['nginx']['dir']}/nginx.conf" do
  source 'nginx.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :reload, 'service[nginx]'
end

%w(default nginx_status).each do |site|
  template "#{node['nginx']['dir']}/sites-available/#{site}" do
    source "#{site}.erb"
    owner 'root'
    group 'root'
    mode '0644'
  end
end

%w(default nginx_status).each do |site|
  link "#{node['nginx']['dir']}/sites-enabled/#{site}" do
    to "#{node['nginx']['dir']}/sites-available/#{site}"
    notifies :reload, 'service[nginx]'
  end
end

service 'nginx' do
  action [:enable, :start]
end
