#
# Cookbook Name:: 7zip
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
# install 7zip
windows_package "7-Zip for 64-bit Windows x64" do
<<<<<<< HEAD
  source node[:tool][:install_url]
  action :install
  not_if {::File.exists?("C:/Program Files/7-zip/7z.exe")}
=======
  source node[:7zip][:7zip_url]
  action :install
>>>>>>> d69eb37d11c0503075661b052fcf9c9f01b35586
  not_if {reboot_pending?}
end

# if feature installs, schedule a reboot at end of chef run
windows_reboot 60 do
  reason 'reboot needed'
  only_if {reboot_pending?}
end 