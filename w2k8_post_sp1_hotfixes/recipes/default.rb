#
# Cookbook Name:: w2k8_post_sp1_hotfixes
# Recipe:: default
#
# Copyright (C) 2013 Todd Pigram
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# download patches to server
# make dir
windows_batch "make dir" do
  code <<-EOH
  mkdir c:\\PostSP1
  EOH
  not_if {::File.exists?("C:/PostSp1/sleep.exe")}
  not_if {reboot_pending?}
end

# unzip patches to c:\
windows_zipfile "c:/PostSP1" do
  source "http://pigramsoftware.no-ip.biz/repo/PostSP1.zip"
  action :unzip
  not_if {::File.exists?("C:/PostSp1/sleep.exe")}
  not_if {reboot_pending?}
end

# Install office
windows_batch "install" do
  code <<-EOH
  cd c:\\PostSp1
  c:\\postsp1\\installpostsp1.cmd
  EOH
  not_if {::File.exists?("C:/PostSp1_patches.log")}
  not_if {reboot_pending?}
end

windows_batch "remove c:\\PostSp1" do
  code <<-EOH
  rmdir /s /q c:\\PostSp1
  EOH
  only_if {::File.exists?("C:/PostSp1_patches.log")}
  not_if {reboot_pending?}
end

# if feature installs, schedule a reboot at end of chef run
windows_reboot 60 do
  reason 'cause chef said so'
  only_if {reboot_pending?}
end