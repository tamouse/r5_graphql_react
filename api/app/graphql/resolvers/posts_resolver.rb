class Resolvers::PostsResolver

  def initialize(resolver)
    @resolver = resolver
  end

  ##
  # The arguments specified in the query:
  #
  # @option args [String] :ids Comma-separated string of post IDs
  # @option args [String] :title_contains Fragment to use to look up posts by title
  # @option args [String Date] :since ISO-format date that is used to retrieve posts after
  # @option args [Boolean] :published_only Only return published posts
  # @option args [Boolean] :drafts_only Only return unpublished posts
  # @option args [String] :sort_by Field name to sort by
  # @option args [String] :direction Direction sort by "asc", "desc"
  # @option args [Int] :page Page of posts to return
  # @option args [Int] :per_page Number of posts to return
  def call(object, args, context)
    posts = @resolver.call(object, args, context)
    posts = posts.where(id: args[:ids]) if args[:ids]
    posts = posts.where('title ilike ?', "%#{args[:title_contains]}%") if args[:title_contains]
    posts = posts.where('published_at after ?', args[:since]) if args[:since]
    posts = posts.published if args[:published_only]
    posts = posts.drafts if args[:drafts_only]

    if (sort_column = args[:sort_by])
      if (direction = args[:direction])
        posts = posts.order(sort_column.to_sym => direction.to_sym)
      else
        posts = posts.order(sort_column.to_sym) # whatever default sort order is
      end
    end

    posts = posts.paginate(page: args[:page], per_page: args[:per_page])

    posts
  end
end
