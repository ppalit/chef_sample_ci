#
# Cookbook:: org_base
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

group 'create the group' do
  group_name node['group']
  not_if { node['group'].nil? }
end

user "create user #{node['user']}" do
  username node['user']
  group node['group']
  manage_home true
end


file 'creates the hello.txt file' do
  path "/home/#{node['user']}/hello.txt"
  content "hello #{node['user']}"
  mode '0600'
  owner node['user']
  only_if { node['hello'] }
end
