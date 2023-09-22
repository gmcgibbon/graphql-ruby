# frozen_string_literal: true

module GraphQL
  class Railtie < Rails::Railtie
    config.graphql = ActiveSupport::OrderedOptions.new
    config.graphql.parser_cache = false

    config.before_initialize do
      if !config.graphql.parser_cache && ::Object.const_defined?("Bootsnap::CompileCache::ISeq") && Bootsnap::CompileCache::ISeq.cache_dir
        Deprecation.warn <<~MSG.squish
          The GraphQL parser cache must be explicitly enabled in your application.
          Please add `config.graphql.parser_cache = true` to your application config.
        MSG
        config.graphql.parser_cache = true
      end
    end

    initializer("graphql.cache") do |app|
      if config.graphql.parser_cache
        Language::Parser.cache ||= Language::Cache.new(
          app.root.join("tmp/cache/graphql")
        )
      end
    end
  end
end
