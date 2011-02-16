#
# Cookbook Name:: git
# Recipe:: default
#
# Copyright 2008-2009, Opscode, Inc.
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

remote_file "/tmp/git-#{node[:git][:version]}.tar.bz2" do
  source "#{node[:git][:url]}"
  not_if { ::File.exists?("/tmp/git-#{node[:git][:version]}.tar.bz2") }
end

if node[:git][:install_from_source]
  bash "Install Git from Source" do
    cwd "/tmp"
    code <<-EOH
    apt-get build-dep git-core -y
    tar xvfj git-#{node[:git][:version]}.tar.bz2
      cd git-#{node[:git][:version]}
      make prefix=#{node[:git][:install_path]} install
      EOH
    not_if do
      ::File.exists?("#{node[:git][:install_path]}/bin/git") &&
        system("#{node[:git][:install_path]}/bin/git --version | grep -q '#{node[:git][:version]}'")
    end
  end
else
  case node[:platform]
  when "debian", "ubuntu"
    package "git-core"
  else
    package "git"
  end
end
