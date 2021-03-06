set_unless[:mongodb][:user]  = "mongodb"
set_unless[:mongodb][:group] = "mongodb"

set_unless[:mongodb][:bind_address] = "127.0.0.1"
set_unless[:mongodb][:port]         = "27017"

set_unless[:mongodb][:version]   = '1.6.5'
set_unless[:mongodb][:file_name] = "mongodb-linux-#{kernel[:machine] || 'i686'}-#{mongodb[:version]}"
set_unless[:mongodb][:url]       = "http://fastdl.mongodb.org/linux/#{mongodb[:file_name]}.tgz"

set_unless[:mongodb][:root]       = "/usr/local/mongodb"
set_unless[:mongodb][:data_dir]   = "/var/lib/mongodb"
set_unless[:mongodb][:log_dir]    = "/var/log/mongodb"
set_unless[:mongodb][:config_dir] = "/etc/mongodb"
set_unless[:mongodb][:pid_dir]    = "/var/run"

set_unless[:mongodb][:username] = ''
set_unless[:mongodb][:password] = ''
set_unless[:mongodb][:database] = ''