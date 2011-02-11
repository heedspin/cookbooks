#
# Cookbook Name:: apache2
# Attributes:: apache
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

# Where the various parts of apache are
case platform
when "redhat","centos","fedora","suse"
  set[:apache][:dir]     = "/etc/httpd"
  set[:apache][:log_dir] = "/var/log/httpd"
  set[:apache][:user]    = "apache"
  set[:apache][:binary]  = "/usr/sbin/httpd"
  set[:apache][:icondir] = "/var/www/icons/"
when "debian","ubuntu"
  set[:apache][:dir]     = "/etc/apache2"
  set[:apache][:log_dir] = "/var/log/apache2"
  set[:apache][:user]    = "www-data"
  set[:apache][:binary]  = "/usr/sbin/apache2"
  set[:apache][:icondir] = "/usr/share/apache2/icons"
else
  set[:apache][:dir]     = "/etc/apache2"
  set[:apache][:log_dir] = "/var/log/apache2"
  set[:apache][:user]    = "www-data"
  set[:apache][:binary]  = "/usr/sbin/apache2"
  set[:apache][:icondir] = "/usr/share/apache2/icons"
end

###
# These settings need the unless, since we want them to be tunable,
# and we don't want to override the tunings.
###

# General settings
default_unless[:apache][:listen_ports] = [ "80","443" ]
default_unless[:apache][:contact] = "ops@example.com"
default_unless[:apache][:timeout] = 300
default_unless[:apache][:keepalive] = "On"
default_unless[:apache][:keepaliverequests] = 100
default_unless[:apache][:keepalivetimeout] = 5

# Security
default_unless[:apache][:servertokens] = "Prod"
default_unless[:apache][:serversignature] = "On"
default_unless[:apache][:traceenable] = "On"

# mod_auth_openids
default_unless[:apache][:allowed_openids] = Array.new

# Prefork Attributes
default_unless[:apache][:prefork][:startservers] = 16
default_unless[:apache][:prefork][:minspareservers] = 16
default_unless[:apache][:prefork][:maxspareservers] = 32
default_unless[:apache][:prefork][:serverlimit] = 400
default_unless[:apache][:prefork][:maxclients] = 400
default_unless[:apache][:prefork][:maxrequestsperchild] = 10000

# Worker Attributes
default_unless[:apache][:worker][:startservers] = 4
default_unless[:apache][:worker][:maxclients] = 1024
default_unless[:apache][:worker][:minsparethreads] = 64
default_unless[:apache][:worker][:maxsparethreads] = 192
default_unless[:apache][:worker][:threadsperchild] = 64
default_unless[:apache][:worker][:maxrequestsperchild] = 0

# Web App Attributes
default_unless[:apache][:server_name]    = ""  
default_unless[:apache][:server_aliases] = ""
default_unless[:apache][:docroot]        = "/var/www"
default_unless[:apache][:name]           = "site"
default_unless[:apache][:vhost_port]     = "80"
default_unless[:apache][:vhosts]         = []

# Log rotation
default_unless[:apache][:logrotate][:interval] = 'daily'
default_unless[:apache][:logrotate][:keep_for] = '7'
