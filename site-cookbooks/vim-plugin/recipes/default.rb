#
# Cookbook Name:: vim-plugin
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

directory "/home/#{node['user']}/.vim" do
  owner node['user']
  group node['group']
  mode '0755'
  action :create
end

%w(backup bundle swap).each do |dir|
  directory "/home/#{node['user']}/.vim/#{dir}" do
    owner node['user']
    group node['group']
    mode '0755'
    action :create
  end
end

execute 'install neobundle' do
  user node['user']
  group node['group']
  cwd "/home/#{node['user']}"
  command 'curl -L https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh'
  environment 'HOME' => "/home/#{node['user']}"
  not_if { File.exists?("/home/#{node['user']}/.vim/bundle/neobundle.vim") }
end

%w(.vimrc_scss_indent .vimrc).each do |file|
  cookbook_file "/home/#{node['user']}/#{file}" do
    owner node['user']
    group node['group']
    mode '0644'
  end
end
