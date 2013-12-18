#
# Cookbook Name:: acrobat
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
# Install acrobat Reader 11.0
windows_package "AdbeRdr11000_en_US" do
  source node[:acrobat][:install_url]
  action :install
  not_if {::File.exists?("C:/Program Files (x86)/Adobe/Reader 11.0/Reader/AcroRd32.exe")}
  not_if {reboot_pending?}
end

# disable acrobat update
registry_key node[:acrobat][:featurelockdown] do
  values [{
    :name => "bUpdater",
    :type => :dword,
    :data => 00000000
    }]
  recursive true
  action :create
end