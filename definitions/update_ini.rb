#
# Cookbook Name:: ini_updater
# Definition:: update_ini
#
# Copyright 2014, Endre Fejes
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'tempfile'
require 'fileutils'

define :update_ini, :settings => {} do
    path = params[:name]
    settings = params[:settings]
    matched = []
    file_name = File.basename(path)

    # Creating temp file ...
    temp_file = Tempfile.new(file_name)
    temp_file.close()
    # ... and overriding it, to keep permissions
    FileUtils.cp(path, temp_file.path, :preserve => true)
    File.open(temp_file.path, "w") do |temp_file|
        File.open(path, "r") do |file|
            file.each do |line|
                settings.each do |name, value|
                    if value and line.match(/^\s*#{name}\s*=\s*#{value}\s*$/) then
                        matched.push(name)
                    elsif line.match(/^\s*#{name}\s*=/) then
                        line.gsub!(/^/, "; ")
                    end
                end
                temp_file.puts(line)
            end
        end
        settings.each do |name, value|
            if value != nil and !matched.include?(name) then
                temp_file.puts("#{name} = #{value}")
            end
        end
        temp_file.close()
        FileUtils.mv(temp_file.path, path)
    end
end
