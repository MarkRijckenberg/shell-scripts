# Copyright 2011 MaestroDev
# 2013 Updated by Mark Rijckenberg
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


# PREREQUISITES: git vagrant vagrant-hostmaster 
# Install prerequisites via this Terminal command:
# $ sudo gem install git vagrant vagrant-hostmaster

require 'rubygems'
require 'git'

modules = ["maven", "wget"]

modules.each do |m|
  repo = "git://github.com/maestrodev/puppet-#{m}.git"
  dir = "modules/#{m}"
  if !File.exist?(dir)
    puts "Fetch puppet module #{m} from #{repo}"
    Git.clone(repo, dir)
  else
    # Git.open(dir).pull
  end
end

 
Vagrant::Config.run do |config|

  # Every Vagrant virtual environment requires a box to build off of.
   config.vm.box = "Ubuntu 12.10 Server Quantal x86_64 (Guest Additions 4.2.2 + Brightbox's Ruby 1.9.3 + Chef)"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
   config.vm.box_url = "/media/IOMEGA/VirtualBoxMachines/ubuntuserver1210.box"
  # config.vm.box_url = "http://static.aldoborrero.com/vagrant/quantal64.box"


  # Boot with a GUI so you can see the screen. (Default is headless)
  #config.vm.boot_mode = :gui

  config.vm.share_folder("templates", "/tmp/vagrant-puppet/templates", "templates")
  # Configure our extra puppet modules
  config.vm.share_folder("modules", "/tmp/vagrant-puppet/modules", "modules")

  # Puppet master, configured from manifests/base.pp
  config.vm.define :master do |master_config|
    master_config.vm.host_name = "puppet.local"
    master_config.vm.network :hostonly, "10.0.0.10"
    # Configure the Puppet manifests that this VM will serve
    master_config.vm.share_folder("manifests", "/tmp/vagrant-puppet/manifests", "manifests")

    master_config.vm.provision :puppet do |p|
      p.manifest_file  = "master.pp"
      p.module_path = "modules"
      p.options = ["--templatedir","/tmp/vagrant-puppet/templates"]
    end
  end

  # Puppet client, configured from Puppet master
  # Puppet needs to run twice
  # First run needs to install buildr and its dependencies, so the plugins work next invocations
  config.vm.define :client do |client_config|
    client_config.vm.host_name = "client.local"
    client_config.vm.network :hostonly, "10.0.0.20"
    client_config.vm.provision :puppet do |p|
      p.manifest_file  = "client.pp"
      p.options = ["--templatedir","/tmp/vagrant-puppet/templates"]
      p.puppet_server = "puppet.local"
      p.puppet_node = "client.local"
    end
  end

end

