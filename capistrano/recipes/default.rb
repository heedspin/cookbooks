#
# Cookbook Name:: capistrano
# Recipe:: default
#
# Copyright 2009, Opscode, Inc.
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

gem_package "capistrano"

cap_setup do
  path      "#{node[:app][:root_dir]}"
  owner     "#{node[:capistrano][:deploy_user]}"
  group     "#{node[:capistrano][:deploy_user]}"
  appowner  "#{node[:capistrano][:deploy_user]}"
end