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

%w(backup swap).each do |dir|
  directory "/home/#{node['user']}/.vim/#{dir}" do
    owner node['user']
    group node['group']
    mode '0755'
    action :create
  end
end

execute 'install vim-plug' do
  user node['user']
  group node['group']
  cwd "/home/#{node['user']}"
  environment 'HOME' => "/home/#{node['user']}"
  command "curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  not_if { File.exists?("/home/#{node['user']}/.vim/autoload/plug.vim") }
end

%w(.vimrc_scss_indent .vimrc).each do |file|
  cookbook_file "/home/#{node['user']}/#{file}" do
    owner node['user']
    group node['group']
    mode '0644'
  end
end

execute 'install vim plugin via vim-plug' do
  user node['user']
  group node['group']
  cwd "/home/#{node['user']}"
  environment 'HOME' => "/home/#{node['user']}"
  command "vim -c 'set shortmess=at' +PlugInstall! +qall"
  not_if { File.exists?("/home/#{node['user']}/.vim/plugged") }
end
