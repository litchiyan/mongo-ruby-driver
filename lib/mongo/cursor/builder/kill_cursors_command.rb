# Copyright (C) 2015-2016 MongoDB, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module Mongo
  class Cursor
    module Builder

      # Generates a specification for a kill cursors command.
      #
      # @since 2.2.0
      class KillCursorsCommand
        extend Forwardable

        # @return [ Cursor ] cursor The cursor.
        attr_reader :cursor

        def_delegators :@cursor, :collection_name, :database

        # Create the new builder.
        #
        # @example Create the builder.
        #   KillCursorsCommand.new(cursor)
        #
        # @param [ Cursor ] cursor The cursor.
        #
        # @since 2.2.0
        def initialize(cursor)
          @cursor = cursor
        end

        # Get the specification.
        #
        # @example Get the specification.
        #   kill_cursors_command.specification
        #
        # @return [ Hash ] The spec.
        #
        # @since 2.2.0
        def specification
          { selector: kill_cursors_command, db_name: database.name }
        end

        private

        def kill_cursors_command
          { :killCursors => collection_name, :cursors => [ cursor.id ] }
        end
      end
    end
  end
end
