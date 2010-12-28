#
# Author:: Adam Jacob <adam@opscode.com>
# Cookbook Name:: rubygems
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

node[:rubygems][:gem_sources].each do |domain|
  execute "gem sources --add http://#{domain}" do
    not_if "gem sources --list | grep #{domain}"
  end
end

# ruby 1.9.2 comes with rubygems 1.3.7 pre-installed
case node[:rubygems][:version]
when '1.3.7'
  bash "Update rubygems to 1.3.7" do
    code <<-EOH
    sudo gem update --system
    EOH
    not_if do
      system("gem -v | grep -q '1.3.7'")
    end
  end
when '1.3.6'
  remote_file "/tmp/rubygems-1.3.6.tgz" do
    source "http://rubyforge.org/frs/download.php/69365/rubygems-1.3.6.tgz"
    not_if { ::File.exists?("/tmp/rubygems-1.3.6.tgz") }
  end

  bash "Update rubygems to 1.3.6 from source" do
    cwd "/tmp"
    code <<-EOH
    tar zxf rubygems-1.3.6.tgz
    cd rubygems-1.3.6
    sudo ruby setup.rb
    EOH
    not_if do
      system("gem -v | grep -q '1.3.6'")
    end
    ignore_failure true #TODO this isn't respecting 
  end
end