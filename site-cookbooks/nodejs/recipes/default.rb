#
# Cookbook Name:: nodejs
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "nodejs" do
  action :install
end

execute "install npm" do
  command "curl -L https://www.npmjs.com/install.sh | sh"
  not_if "which npm"
end

%w(phantomjs-prebuilt).each do |pkg|
  execute "npm install #{pkg}" do
    command "npm -g install #{pkg}"
    not_if "npm -g ls --depth=0 | grep #{pkg}"
  end
end
