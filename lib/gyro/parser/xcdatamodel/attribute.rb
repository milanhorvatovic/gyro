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

require_relative 'enum'

module Gyro

	module Parser

		module XCDataModel

			# One Attribute in an Entity of the xcdatamodel
			#
			class Attribute
				attr_accessor :entity_name, :access_control, :name, :type, :custom_type, :optional, :indexed, :default
				attr_accessor :realm_ignored, :realm_read_only, :enum_name, :enum_type, :enum_keys, :enum_values, :enum
				attr_accessor :json_key_path, :json_values, :transformer, :comment, :support_annotation

				alias optional? optional
				alias indexed? indexed
				alias realm_ignored? realm_ignored

				# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
				def initialize(attribute_xml, entity_name, access_control)
					@entity_name = entity_name
					@access_control = Gyro::Parser::XCDataModel.user_info(attribute_xml, 'accessControl')
					@access_control = access_control if @access_control.nil? || @access_control.empty?
					@name = attribute_xml.attributes['name'].to_s
					@optional = attribute_xml.attributes['optional'].to_s == 'YES'
					@indexed = attribute_xml.attributes['indexed'].to_s == 'YES'
					@default = attribute_xml.attributes['defaultValueString'].to_s
					@default = nil if @default.nil? || @default.empty?
					@type = attribute_xml.attributes['attributeType'].to_s.downcase.tr(' ', '_').to_sym
					@custom_type = Gyro::Parser::XCDataModel.user_info(attribute_xml, 'customType')
					@realm_ignored = !Gyro::Parser::XCDataModel.user_info(attribute_xml, 'realmIgnored').empty?
					@realm_read_only = Gyro::Parser::XCDataModel.user_info(attribute_xml, 'realmReadOnly')
					@enum_name = Gyro::Parser::XCDataModel.user_info(attribute_xml, 'enumName')
					@enum_type = Gyro::Parser::XCDataModel.user_info(attribute_xml, 'enumType')
					@enum_keys = Gyro::Parser::XCDataModel.user_info(attribute_xml, 'enumKeys').split(',').map(&:strip)
					@enum_values = Gyro::Parser::XCDataModel.user_info(attribute_xml, 'enumValues').split(',').map(&:strip)
					if !Gyro::Parser::XCDataModel.user_info(attribute_xml, 'enumName').empty?
						@enum = Enum.new(attribute_xml, @name)
					end
					@json_key_path = Gyro::Parser::XCDataModel.user_info(attribute_xml, 'JSONKeyPath')
					@json_values = Gyro::Parser::XCDataModel.user_info(attribute_xml, 'JSONValues').split(',')
					@transformer = Gyro::Parser::XCDataModel.user_info(attribute_xml, 'transformer').strip
					@comment = Gyro::Parser::XCDataModel.user_info(attribute_xml, 'comment')
					@support_annotation = Gyro::Parser::XCDataModel.user_info(attribute_xml, 'supportAnnotation')
					search_for_error
				end

				def to_h
					{
						'entity_name' => entity_name, 
						'access_control' => access_control,
						'name' => name,
						'type' => type.to_s,
						'custom_type' => custom_type,
						'optional' => optional,
						'indexed' => indexed,
						'default' => default,
						'realm_ignored' => realm_ignored, 'realm_read_only' => realm_read_only,
						'enum' => enum.to_h,
						'enum_type' => enum_type, 'enum_values' => enum_values,
						'json_key_path' => json_key_path, 'json_values' => json_values,
						'transformer' => transformer, 'need_transformer' => need_transformer?,
						'comment' => comment,
						'support_annotation' => support_annotation,
						'is_custom_type' => custom_type?, 'is_decimal' => decimal?, 'is_integer' => integer?, 'is_number' => number?, 'is_bool' => bool?, 'is_string' => string?, 'has_default' => default?
					}
				end
				# rubocop:enable Metrics/AbcSize, Metrics/MethodLength

				def enum?
					!@enum_type.empty?
				end

				def read_only?
					!@realm_read_only.empty?
				end

				def default?
					!@default.nil? && !@default.empty?
				end

				def to_s
					items = [
						"name=#{@name}",
						"type=#{@type}",
						"custom_type=#{@custom_type}",
						"optional=#{@optional}",
						"default=#{@default}",
						"enum=#{@enum}",
						"indexed=#{@indexed}"
					]
					"\tAttribute => " + items.join(' | ') + "\n"
				end

				def decimal?
					(@type == :decimal) || (@type == :double) || (@type == :float)
				end

				def integer?
					(@type == :integer_16) || (@type == :integer_32) || (@type == :integer_64)
				end

				def number?
					decimal? || integer?
				end

				def bool?
					@type == :boolean
				end
				
				def string?
					@type == :string
				end

				def need_transformer?
					!@enum_type.empty? || (@type == :boolean) || (@type == :date) || !@transformer.empty?
				end

				def custom_type?
					!@custom_type.empty?
				end

				private ################################################################

				def search_for_error
					# rubocop:disable Style/GuardClause
					if @type == :undefined || @type.empty?
						msg = %(The attribute "#{@name}" from "#{@entity_name}" has no type - please fix it)
						Gyro::Log.fail!(msg, stacktrace: true)
					end
					if !@json_key_path.empty? && !@enum_values.empty? && (@enum_values.size != @json_values.size)
						message = %(The attribute "#{@name}" from "#{@entity_name}" is wrongly annotated:) +
								%(when declaring an type with enum and JSONKeyPath, you must have the same number of items) +
								%(in the 'enumValues' and 'JSONValues' annotations.)
						Gyro::Log.fail!(message, stacktrace: true)
					end
					# rubocop:enable Style/GuardClause
				end

		  	end
		  
    	end
  
	end

end
