# Copyright 2016 - Niji
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

include REXML

module Gyro

	module Parser

		# Parser for CoreData's xcdatamodel files
		#
		module XCDataModel

			def self.find_in_dir(dir)
				Dir.chdir(dir) do
				files = Dir.glob('*.xcdatamodel')
				files.first.nil? ? nil : File.expand_path(files.first, dir)
				end
			end

			def self.user_info(xml, key)
				XPath.first(xml, "userInfo/entry[@key='#{key}']/@value").to_s
			end

			# Represents the whole xcdatamodel file struture, once parsed
			#
			class XCDataModel
				
				attr_accessor :entities

				def initialize(xcdatamodel_dir)
					contents_file = File.join(xcdatamodel_dir, 'contents')
					Gyro::Log.fail!('Unable to find contents of xcdatamodel', stacktrace: true) unless File.exist?(contents_file)
					@entities = {}
					file = File.open(contents_file)
					document_xml = Document.new(file)
					file.close
					load_entities(document_xml)
				end

				def to_h
					{ 'entities' => entities.values.map(&:to_h) }
				end

				def to_s
					@entities.values.map(&:to_s).join
				end

				private

				def load_entities(document_xml)
					document_xml.root.each_element('//entity') do |node|
					entity = Entity.new(node)
					@entities[entity.name] = entity
					end
				end

			end

		end
	
	end

end
