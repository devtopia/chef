#
# Cookbook Name:: ruby-env
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w(gcc git openssl-devel readline-devel).each do |pkg|
  package pkg do
    action :install
  end
end

git "/home/#{node['user']}/.rbenv" do
  repository node['ruby-env']['rbenv_url']
  action :sync
  user node['user']
  group node['group']
end

template ".bash_profile" do
  source '.bash_profile.erb'
  path "/home/#{node['user']}/.bash_profile"
  mode '0644'
  owner node['user']
  group node['group']
  not_if "grep rbenv ~/.bash_profile", :environment => {:'HOME' => "/home/#{node['user']}"}
end

directory "/home/#{node['user']}/.rbenv/plugins" do
  owner node['user']
  group node['group']
  mode '0755'
  action :create
end

git "/home/#{node['user']}/.rbenv/plugins/ruby-build" do
  repository node['ruby-env']['ruby-build_url']
  action :sync
  user node['user']
  group node['group']
end

execute "rbenv install #{node['ruby-env']['version']}" do
  command "/home/#{node['user']}/.rbenv/bin/rbenv install #{node['ruby-env']['version']}"
  user node['user']
  group node['group']
  environment 'HOME' => "/home/#{node['user']}"
  not_if { File.exists?("/home/#{node['user']}/.rbenv/versions/#{node['ruby-env']['version']}") }
end

execute "rbenv global #{node['ruby-env']['version']}" do
  command "/home/#{node['user']}/.rbenv/bin/rbenv global #{node['ruby-env']['version']}"
  user node['user']
  group node['group']
  environment 'HOME' => "/home/#{node['user']}"
end

%w(rbenv-rehash bundler).each do |gem|
  execute "gem install #{gem}" do
    command "/home/#{node['user']}/.rbenv/shims/gem install #{gem}"
    user node['user']
    group node['group']
    environment 'HOME' => "/home/#{node['user']}"
    not_if "/home/#{node['user']}/.rbenv/shims/gem list | grep #{gem}"
  end
end
