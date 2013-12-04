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

rbenv_home = ::File.join(node['devtool']['home'], ".rbenv")
rbenv_plugin_dir = ::File.join(rbenv_home, 'plugins')
ruby-build_dir = ::File.join(rbenv_plugin_dir, "ruby-build")

git "rbenv" do
  repository 'https://github.com/sstephenson/rbenv.git'
  destination rbenv_home
  reference "master"
  action :sync
  user node['devtool']['user']
  group node['devtool']['group']
end

directory rbenv_plugin_dir do
  owner node['devtool']['user']
  group node['devtool']['group']
  action :create
end

git "ruby-build" do
  repository 'https://github.com/sstephenson/ruby-build.git'
  destination ruby-build_dir
  reference "master"
  action :sync
  user node['devtool']['user']
  group node['devtool']['group']
end

bash_profile 'profile.addin' do
  user node['devtool']['user']
  content "PATH=#{::File.join(rbenv_home, 'shims'}:#{::File.join(rbenv_home, 'bin'}:$PATH"
end

rbenv_ruby "Ruby 1.9.3" do
  ruby_version "1.9.3-p448"
  force false
end
