module Gyro
	
	module Parser

		module XCDataModel

			# One Enum in an Attribute of Entity of the xcdatamodel
			#
			class Enum
				attr_accessor :attribute_name, :name, :type, :values
				
				# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
				def initialize(attribute_xml, attribute_name)
					if Gyro::Parser::XCDataModel.user_info(attribute_xml, 'enumValues').empty?
						msg = %(The enum values from "#{attribute_xml}" are empty - please fix it)
						Gyro::Log.fail!(msg, stacktrace: true)
					end

					@attribute_name = attribute_name
					@name = Gyro::Parser::XCDataModel.user_info(attribute_xml, 'enumName')
					@type = Gyro::Parser::XCDataModel.user_info(attribute_xml, 'enumType')
					@type = 'string' if @type.nil? || @type.empty?
					@values = Gyro::Parser::XCDataModel.user_info(attribute_xml, 'enumValues').split(',').map(&:strip).map!{ |pair| EnumElement.new(pair) }

					search_for_error
				end

				def to_h
					{
						'name' => @name,
						'type' => @type.to_s,
						'values' => @values.map { |value| value.to_h }
					}
				end
				# rubocop:enable Metrics/AbcSize, Metrics/MethodLength

				def to_s
					items = [
						"name=#{@name}",
						"type=#{@type}",
						"values=#{@values.map { |value| value.to_s }}"
						]
					"\tEnum => " + items.join(' | ') + "\n"
				end

				private ################################################################
				
				def search_for_error
					# rubocop:disable Style/GuardClause
					if @type == :undefined || @type.empty?
						msg = %(The attribute "#{@name}" from "#{@entity_name}" has no type - please fix it)
						Gyro::Log.fail!(msg, stacktrace: true)
					end

					if !(@type =~ /^int|integer|interger32|integer64$/i).nil? && !@values.reduce(true) { |result, value| result & value.number? }
						msg = %(The enum "#{@name}" from attribute "#{@attribute_name}" has mismatch of types - please fix it)
						Gyro::Log.fail!(msg, stacktrace: true)
					end
					# rubocop:enable Style/GuardClause
				end
				
			end

			class EnumElement
				attr_accessor :key, :value

				def initialize(enum_value)
					pairs = enum_value.split(':').map(&:strip)
					if pairs.size == 2
						
						if !(pairs[0] =~ /^\'[a-zA-Z]{0,}[a-zA-Z0-9_-]+\'$/).nil?
							@key = pairs[0].tr('\'', '')
						elsif !(pairs[0] =~ /^[a-zA-Z]{0,}[a-zA-Z0-9_-]+$/).nil?
							@key = pairs[0].sub(/^[A-Z]/, &:downcase)
						else
							msg = %(The enum from "#{pairs}" has invalid format - please fix it)
							Gyro::Log.fail!(msg, stacktrace: true)
						end
						@value = pairs[1].tr('\'', '')
					else
						if !(pairs[0] =~ /^\'[a-zA-Z]{0,}[a-zA-Z0-9_-]+\'$/).nil?
							@key = pairs[0].tr('\'', '')
						elsif !(pairs[0] =~ /^[a-zA-Z]{0,}[a-zA-Z0-9_-]+$/).nil?
							@key = pairs[0].sub(/^[A-Z]/, &:downcase)
						else
							msg = %(The enum from "#{pairs}" has invalid format - please fix it)
							Gyro::Log.fail!(msg, stacktrace: true)
						end
						@value = pairs[0].tr('\'', '')
					end
				end

				def to_h
					{
						'key' => @key,
						'value' => @value.to_s,
						'is_number' => number?,
						'is_string' => string?
					}
				end

				def to_s
					items = [
						"key=#{@key}",
						"value=#{@value}"
						]
					"\tEnumElement => " + items.join(' | ') + "\n"
				end

				def number?
					!(Integer(@value) rescue nil).nil?
				end

				def string?
					@value.is_a? String
				end

			end
			
		end

	end
	
end
	