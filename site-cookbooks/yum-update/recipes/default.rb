#
# Cookbook Name:: yum-update
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute 'yum-update' do
  user 'root'
  command 'yum -y update'
  action :run
end
