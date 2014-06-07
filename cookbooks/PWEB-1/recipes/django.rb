#
# Cookbook Name:: django
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

remote_file "#{Chef::Config['file_cache_path']}/epel-release-6-8.noarch.rpm" do
  source "https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm"
  action :create_if_missing
end


package 'epel-release-repo' do
  source "#{Chef::Config['file_cache_path']}/epel-release-6-8.noarch.rpm"
  provider Chef::Provider::Package::Rpm
  action :install
end


%w{python-pip mod_wsgi httpd}.each do |p|
        package p do
                action :install
        end
end


bash "pip" do
  user "root"
  cwd "/tmp"
  code "/usr/bin/pip install django"
  action :run
end


service "httpd" do
  supports :status => true, :start => true, :stop => true, :restart => true
  action [ :enable, :start ]
end

