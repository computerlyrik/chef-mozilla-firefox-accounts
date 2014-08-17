#
# Cookbook Name:: mozilla-firefox-accounts
# Recipe:: fxa-auth-server
#
# Copyright 2014, computerlyrik, Christian Fischer
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
#

package 'libgmp'
package 'libgmp-dev'

include_recipe 'mozilla-firefox-accounts::fxa-auth-server'

nodejs_npm 'grunt-cli'
nodejs_npm 'phantomjs'

nodejs_npm 'fxa-content-server' do
  url 'github mozilla/fxa-content-server.git'
  version 'v0.19.0'
  options ['--production']
end
