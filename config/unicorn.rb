
root = "/home/vagrant/project_test/current"
worker_processes 4
working_directory "/home/vagrant/project_test/current" # available in 0.94.0+
listen "/tmp/unicorn.project_test.sock", :backlog => 64
listen 8080, :tcp_nopush => true
timeout 30
pid "/home/vagrant/project_test/current/tmp/pids/unicorn.pid"
stderr_path "/home/vagrant/project_test/current/log/unicorn.stderr.log"
stdout_path "/home/vagrant/project_test/current/log/unicorn.stdout.log"
