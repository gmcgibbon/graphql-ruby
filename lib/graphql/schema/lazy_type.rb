# frozen_string_literal: true

module GraphQL
  class Schema
    class LazyType
      def initialize(type_expr)
        @expr = type_expr
      end

      attr_reader(:kind)

      def unwrap
        self
      end

      def name
        "CoolString"
      end

      def graphql_name
        nil
      end

      def to_non_null_type
        NonNull.new(self)
      end
    end
  end
end
