#
# Cookbook Name:: lua
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'lua-devel' do
  action :install
end

src_filepath = "#{Chef::Config['file_cache_path']}/luajit"

git "#{src_filepath}" do
  repository node['lua']['luajit_url']
  user 'root'
  group 'root'
end

bash 'install luajit' do
  code <<-EOH
    cd #{src_filepath}
    make && make install
  EOH
  not_if { File.exists?("/usr/local/bin/luajit") } 
end
