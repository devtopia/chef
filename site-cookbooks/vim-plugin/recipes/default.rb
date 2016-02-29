#
# Cookbook Name:: vim-plugin
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "vim" do
  action :install
end

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
  environment 'HOME' => "/home/#{node['user']}"
  command "curl -L https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh"
  not_if { File.exists?("/home/#{node['user']}/.vim/bundle/neobundle.vim") }
end

%w(.vimrc_scss_indent .vimrc).each do |file|
  cookbook_file "/home/#{node['user']}/#{file}" do
    owner node['user']
    group node['group']
    mode '0644'
  end
end

execute 'install vim plugin via neobundle' do
  user node['user']
  group node['group']
  cwd "/home/#{node['user']}"
  environment 'HOME' => "/home/#{node['user']}"
  command "sudo -u #{node['user']} /home/#{node['user']}/.vim/bundle/neobundle.vim/bin/neoinstall 1>.vim-neoinstalled 2>.vim-neoinstalled"
  not_if { File.exists?("/home/#{node['user']}/.vim-plugin_installed") }
end
