package :deploy_user do

  version "2.1"

  DEPLOY_USER = fetch :user
  DEPLOY_GROUP =fetch :user_group

  noop do

    pre :install, "groupadd #{DEPLOY_GROUP}"
    pre :install, "useradd -g #{DEPLOY_GROUP} -c 'Rails Deployer' -m -s /bin/bash #{DEPLOY_USER}"
    post :install, "mkdir /u"
    post :install, "chown -R #{DEPLOY_USER}:#{DEPLOY_GROUP} /u"
  end

  verify do
    file_contains '/etc/passwd', "#{DEPLOY_USER}:"
    has_directory "/home/#{DEPLOY_USER}"
  end

end

package :deploy_keys do

  remote_auth_file = "/home/#{DEPLOY_USER}/.ssh/authorized_keys"

  noop do
    pre :install, "mkdir -p /home/#{DEPLOY_USER}/.ssh"
    pre :install, "touch #{remote_auth_file}"
  end

  puts "** Reading key files ** #{Dir.glob("keydir/*.pub")}"
  authorized_keys = Dir.glob(File.expand_path("../../../keydir",__FILE__)+"/*.pub").map do |keyfile|
    File.read(keyfile)
  end.join("")

  push_text authorized_keys, remote_auth_file, :sudo => true
  
  noop do
    post :install, "chown -R #{DEPLOY_USER}:#{DEPLOY_GROUP} /home/#{DEPLOY_USER}/.ssh/"
    post :install, "chmod 0600 #{remote_auth_file}"
  end

  verify do
    file_contains remote_auth_file, "ssh-rsa"
  end

end
