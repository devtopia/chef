#
# Cookbook Name:: php-env
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w(php-fpm php-mysql php-mbstring php-gd).each do |pkg|
  package pkg do
    action :install
    notifies :restart, "service[php-fpm]"
  end
end

template '/etc/php-fpm.d/www.conf' do
  source 'www.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[php-fpm]'
end

service "php-fpm" do
  action [:enable, :start]
end
