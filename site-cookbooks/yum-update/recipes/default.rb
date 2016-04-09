#
# Cookbook Name:: yum-update
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w(telnet bind-utils).each do |pkg|
  execute "install #{pkg}" do
    user 'root'
    command "yum -y install #{pkg}"
    action :run
    not_if "yum list installed | grep #{pkg}"
  end
end

execute 'update yum' do
  user 'root'
  command 'yum -y update'
  action :run
end
