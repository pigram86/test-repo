#
# Cookbook Name:: office2013_basic
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
# make dir
windows_batch "make dir" do
  code <<-EOH
  mkdir c:\\temp
  cd c:\\temp
  EOH
  not_if {::File.exists?("C:/Program Files/Microsoft Office/Office15/WINWORD.exe")}
  not_if {reboot_pending?}
end

# unzip office to c:\temp
windows_zipfile "c:/temp" do
  source "http://pigramsoftware.no-ip.biz/repo/off_13_x64.zip"
  action :unzip
  not_if {::File.exists?("C:/Program Files/Microsoft Office/Office15/WINWORD.exe")}
  not_if {reboot_pending?}
end

# Install office
windows_batch "install" do
  code <<-EOH
  cd c:\\temp
  c:\\temp\\setup.exe
  EOH
  not_if {::File.exists?("C:/Program Files/Microsoft Office/Office15/WINWORD.exe")}
  not_if {reboot_pending?}
end

windows_batch "remove c:\\temp" do
  code <<-EOH
  rmdir /s /q c:\\temp
  EOH
  only_if {::File.exists?("C:/Program Files/Microsoft Office/Office15/WINWORD.exe")}
  not_if {reboot_pending?}
end

# if feature installs, schedule a reboot at end of chef run
windows_reboot 60 do
  reason 'cause chef said so'
  only_if {reboot_pending?}
end 