default[:ubuntu][:proxy_server][:ip]     = "127.0.0.1"
default[:ubuntu][:proxy_server][:fqdn]   = 'proxy.fr2.ec2.internal'
default[:ubuntu][:proxy_server][:alias]  = 'proxy'
default[:ubuntu][:static_server][:ip]    = "127.0.0.1"
default[:ubuntu][:static_server][:fqdn]  = 'static.fr2.ec2.internal'
default[:ubuntu][:static_server][:alias] = 'static'
default[:ubuntu][:worker_server][:ip]    = "127.0.0.1"
default[:ubuntu][:worker_server][:fqdn]  = 'worker.fr2.ec2.internal'
default[:ubuntu][:worker_server][:alias] = 'worker'
default[:ubuntu][:database][:ip]         = "127.0.0.1"
default[:ubuntu][:database][:fqdn]       = 'database.fr2.ec2.internal'
default[:ubuntu][:database][:alias]      = 'database'
default[:ubuntu][:sphinx][:ip]           = "127.0.0.1"
default[:ubuntu][:sphinx][:fqdn]         = 'sphinx.fr2.ec2.internal'
default[:ubuntu][:sphinx][:alias]        = 'sphinx' 

default[:ubuntu][:backup_log_dir] = "/mnt/backup.log"