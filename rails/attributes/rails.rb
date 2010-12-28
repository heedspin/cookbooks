default[:rails][:version]       = false
default[:rails][:environment]   = "production"
default[:rails][:max_pool_size] = 4

# log rotation via logrotate
default[:rails][:logrotate][:interval] = 'daily'
default[:rails][:logrotate][:keep_for] = 7

# place config files in aws to easily share them between 
# app servers and seemlessly update them when needed
# eg when spun up from an older AMI.
default_unless[:rails][:aws_config_files] = []

default_unless[:rails][:using_shared] = true

if node[:rails][:using_shared]
  default_unless[:rails][:db_directory] = "#{node[:app][:root_dir]}/shared"
else
  default_unless[:rails][:db_directory] = "#{node[:app][:root_dir]}"
end