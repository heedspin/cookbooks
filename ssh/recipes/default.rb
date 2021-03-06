#
# Cookbook Name:: ssh
# Recipe:: default
#
# Copyright 2010, Bob Burbach
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

service "ssh" do
  case node[:platform]
  when "centos","redhat","fedora"
    service_name "sshd"
  else
    service_name "ssh"
  end
  supports :restart => true
  action [ :enable, :start ]
end

cookbook_file "/etc/ssh/ssh_config" do
  source "ssh/ssh_config"
  owner "root"
  group "root"
  mode "0755"
  action :create
  notifies :restart, resources(:service => "ssh")
end