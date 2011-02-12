default_unless[:git][:version] = "1.7.4"
default_unless[:git][:url]     = "http://kernel.org/pub/software/scm/git/git-#{node[:git][:version]}.tar.bz2"

default_unless[:git][:install_path] = '/usr/local'