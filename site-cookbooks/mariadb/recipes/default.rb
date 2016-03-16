#
# Cookbook Name:: mariadb
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file '/etc/yum.repos.d/MariaDB.repo' do
  owner 'root'
  group 'root'
  mode '0644'
end

%w(MariaDB-server MariaDB-client MariaDB-devel).each do |pkg|
  package pkg do
    action :install
  end
end

service 'mysql' do
  action [:enable, :start]
end
