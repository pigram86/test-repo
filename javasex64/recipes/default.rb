#
# Cookbook Name:: javasex64
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
# Instal javase
windows_Package "jre-7u40-windows-x64" do
  source "http://pigramsoftware.no-ip.biz/repo/jdk-7u45-windows-x64.exe"
  options "/qn"
  installer_type :custom
  action :install
  not_if {::FILE.exists?("C:\\Program Files\\Java\\jdk1.7.0_45\\jre.msi")}
  not_if {reboot_pending?}
end

# disable java update
registry_key "HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\JavaSoft\\Java Update\\Policy" do
  values [{
    :name => "EnableJavaUpdate",
    :type => :dword,
    :data => 00000000
    }]
  recursive true
  action :create
end


# if feature installs, schedule a reboot at end of chef run
windows_reboot 60 do
  reason 'cause chef said so'
  only_if {reboot_pending?}
end 