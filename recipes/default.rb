#
# Cookbook Name:: chef-devtools
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'
package 'git' do
  action :install
end

git "rbenv" do
  repository 'https://github.com/sstephenson/rbenv.git'
  destination node['devtool']['home'] + '/.rbenv'
  reference "master"
  action :sync
  user node['devtool']['user']
  group node['devtool']['group']
end

directory node['devtool']['home'] + '/.rbenv/plugins' do
  owner node['devtool']['user']
  group node['devtool']['group']
  action :create
end

git "ruby-build" do
  repository 'https://github.com/sstephenson/ruby-build.git'
  destination node['devtool']['home'] + '/.rbenv/plugins/ruby-build'
  reference "master"
  action :sync
  user node['devtool']['user']
  group node['devtool']['group']
end

bash_profile 'profile.addin' do
  user 'vagrant'
  content 'PATH='+node['devtool']['home']+'/.rbenv/shims:'+node['devtool']['home']+'/.rbenv/bin:$PATH'
end

rbenv_ruby "Ruby 1.9.3" do
  ruby_version "1.9.3-p448"
  force false
end
