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

module Gyro

	module Parser

		module XCDataModel

			# One Entity in the xcdatamodel
			#
			class Entity

				attr_accessor :name, :parent, :abstract, :access_control, :attributes, :relationships, :identity_attribute, :comment
				alias abstract? abstract

				# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
				def initialize(entity_xml)
					@name = entity_xml.attributes['name'].to_s
					@parent = entity_xml.attributes['parentEntity'].to_s
					@abstract = entity_xml.attributes['isAbstract'].to_s == 'YES'
					@access_control = Gyro::Parser::XCDataModel.user_info(entity_xml, 'accessControl')
					@access_control = 'internal' if @access_control.nil? || @access_control.empty?
					@clean = false
					@identity_attribute = Gyro::Parser::XCDataModel.user_info(entity_xml, 'identityAttribute')
					@comment = Gyro::Parser::XCDataModel.user_info(entity_xml, 'comment')
					@attributes = {}
					@relationships = {}
					load_entity(entity_xml)
				end

				def to_h
					{
						'attributes' => attributes.values.map(&:to_h),
						'relationships' => relationships.values.map(&:to_h),
						'name' => name,
						'parent' => parent,
						'abstract' => abstract,
						'access_control' => access_control,
						'identity_attribute' => identity_attribute,
						'comment' => comment,
						'has_attributes' => attributes?,
						'has_no_inverse_relationship' => no_inverse_relationship?,
						'has_ignored' => ignored_attributes_relationships?, 'has_required' => required_attributes?,
						'has_primary_key' => primary_key?, 'has_indexed_attributes' => indexed_attributes?,
						'has_json_key_path' => json_key_paths?, 'has_enum_attributes' => enum_attributes?,
						'has_custom_transformers' => custom_transformers?, 'need_transformer' => need_transformer?,
						'has_bool_attributes' => bool_attributes?,
						'has_number_attributes' => number_attributes?,
						'has_date_attribute' => date_attributes?,
						'has_list_relationship' => list_relationships?,
						'has_list_attributes' => list_attributes?,
						'has_only_inverse' => only_inverse_relationships?
					}
				end
				# rubocop:enable Metrics/AbcSize, Metrics/MethodLength

				def to_s
					"\nEntity => #{@name}\n" +
						@attributes.map { |_, attr| attr.to_s } +
						@relationships.map { |_, rel| rel.to_s }
				end

				def used_as_list_by_other?(entities)
				entities.any? do |_, entity|
					entity.relationships.any? do |_, relationship|
					(relationship.inverse_type == @name) && (relationship.type == :to_many)
					end
				end
				end

				def list_attributes?(include_inverse = false)
					@relationships.any? do |_, relationship|
						(relationship.type == :to_many) && (include_inverse ? true : !relationship.inverse?)
					end
				end
				
				def attributes?
					!@attributes.nil? && !@attributes.empty?
				end

				def no_inverse_relationship?
					@relationships.none? { |_, relationship| relationship.inverse? }
				end

				def ignored_attributes?
					@attributes.any? { |_, attribute| attribute.realm_ignored? }
				end

				def ignored_relationships?
					@relationships.any? { |_, relationship| relationship.realm_ignored? }
				end

				def ignored_attributes_relationships?
					ignored_attributes? || ignored_relationships?
				end

				def primary_key?
					!@identity_attribute.empty?
				end

				def required_attributes?
					@attributes.any? { |_, attribute| required?(attribute) }
				end

				def required?(attribute)
					return false if attribute.optional?
					return true unless primary_key?
					return true if primary_key? && !attribute.name.eql?(identity_attribute)
				end

				def default_value?(attribute)
					attribute.name != @identity_attribute
				end

				def indexed_attributes?
					@attributes.any? { |_, attribute| attribute.indexed? }
				end

				def json_key_paths?
					@attributes.any? do |_, attribute|
						!attribute.json_key_path.empty?
					end || @relationships.any? do |_, relationship|
						!relationship.inverse? && !relationship.json_key_path.empty?
					end
				end

				def enum_attributes?
					@attributes.any? { |_, attribute| !attribute.enum_type.empty? }
				end

				def transformers
					transformers = Set.new
					@attributes.each_value do |_, attribute|
						transformers.add attribute.transformer unless attribute.transformer.empty?
					end
					transformers
				end

				def custom_transformers?
					@attributes.any? { |_, attribute| !attribute.transformer.empty? }
				end

				def need_transformer?
					enum_attributes? || bool_attributes? || custom_transformers? || date_attributes?
				end

				def bool_attributes?
					@attributes.any? { |_, attribute| attribute.type == :boolean }
				end

				NUMBER_TYPES = %i[integer_16 integer_32 integer_64 decimal double float].freeze
				def number_attributes?
					@attributes.any? do |_, attribute|
						attribute.enum_type.empty? && NUMBER_TYPES.include?(attribute.type)
					end
				end

				def date_attributes?
					@attributes.any? { |_, attribute| attribute.type == :date }
				end

				def list_relationships?
					@relationships.any? { |_, relationship| !relationship.destination.empty? }
				end

				def only_inverse_relationships?
					@relationships.all? { |_, relationship| relationship.inverse? }
				end

				private ################################################################

				def load_entity(entity_xml)
					load_attributes(entity_xml)
					load_relationships(entity_xml)
				end

				def load_attributes(entity_xml)
					entity_xml.each_element('attribute') do |node|
						attribute = Attribute.new(node, @name, @access_control)
						if attribute.type != 'Transformable'
							@attributes[attribute.name] = attribute
						end
					end
				end

				def load_relationships(entity_xml)
					entity_xml.each_element('relationship') do |node|
						relationship = Relationship.new(node, @name)
						@relationships[relationship.name] = relationship
					end
				end

			end
			
		end

	end

end
