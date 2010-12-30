#
# Cookbook Name:: mysql
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
#


if node[:ec2] && ( node[:chef][:roles].include?('staging') || node[:chef][:roles].include?('database') )
  service "mysql" do
    action :stop
  end
  
  unless FileTest.directory?(node[:mysql][:ec2_path])
    execute "install-mysql" do
      command "mv #{node[:mysql][:datadir]} #{node[:mysql][:ec2_path]}"
      user 'root'
      not_if do FileTest.directory?(node[:mysql][:ec2_path]) end
    end
    
    directory node[:mysql][:ec2_path] do
      owner "mysql"
      group "mysql"
      action :create
      recursive true
    end
  end

  %w(/vol/lib/mysql).each do |path|
    directory path do
      owner "mysql"
      group "mysql"
      action :create
      recursive true
    end
  end

  %w(/vol/log/mysql /vol/etc/mysql).each do |path|
    directory path do
      owner "mysql"
      group "mysql"
      action :create
      recursive true
    end
  end

  %w(/etc/mysql /var/lib/mysql /var/log/mysql).each do |path|
    directory path do
      owner "mysql"
      group "mysql"
      mode "0755"
      action :create
      not_if do FileTest.directory?(path) end
    end
  end
  
  # note if you have not setup and mounted an ebs volume to node[:mysql][:ec2_path]
  # you'll want to run the following manually
  #
  # grep -q xfs /proc/filesystems || sudo modprobe xfs
  # sudo mkfs.xfs /dev/sdh
  # 
  # echo "/dev/sdh /vol xfs noatime 0 0" | sudo tee -a /etc/fstab
  # sudo mkdir -m 000 /vol
  # sudo mount /vol

  mount node[:mysql][:datadir] do
    device node[:mysql][:ec2_path]
    fstype "none"
    options "bind"
    action [:enable, :mount]
    # Do not execute if its already mounted (ubunutu/linux only)
    not_if "cat /proc/mounts | grep #{node[:mysql][:datadir]}"
  end
  
  mount "/etc/mysql" do
    device "/vol/etc/mysql"
    fstype "none"
    options "bind"
    action [:enable, :mount]
    # Do not execute if its already mounted (ubunutu/linux only)
    not_if "cat /proc/mounts | grep /etc/mysql"
  end
  
  mount "/var/log/mysql" do
    device "/vol/log/mysql"
    fstype "none"
    options "bind"
    action [:enable, :mount]
    # Do not execute if its already mounted (ubunutu/linux only)
    not_if "cat /proc/mounts | grep /var/log/mysql"
  end
  
  service "mysql" do
    action :start
  end
end