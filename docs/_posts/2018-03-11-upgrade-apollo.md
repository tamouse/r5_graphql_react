---
layout: page
title: "Upgrade to Apollo Client v2"
date: 2018-03-11T00:24
---

Today is the first time I've come back to this learning app since I
stopped working on it shortly after giving that presentation.


## Apollo Client

The Apollo Client upgrade happened just shortly after I gave the
talks, and I upgraded my work project quite successfully. However,
today did not go quite as smoothly, probably because I'm doing more
with the client here than I am there.

Upgrading the various libraries and configurations was not too
difficult, but upgrading some of the other pieces that interfaced with
it on the server side did.

Taking a look at `client/src/App.js`, the differences were well
contained. I think this should probably be refactored, so the client
building stuff can be in it's own space, and the application routes
can be in their own space.

A lot of the change from v1 to v2 involved splitting the client
libraries into separate pieces, so they can be combined and remixed in
more ways.

This app required a separate piece of middleware in order to correctly
inject the authorization header when the token is available. I'm using
`sessionStorage` to keep it in, the JWT itself does not contain any
personal user information, but capturing it could give access to the
application. One thing I think I need to add is a CSRF token as well,
although I'm not sure how I'd get it from the server api.

## Server Side

With the client itself working, I needed to do a bit of work on the
server. My orginal `NullUser` implementation failed to work as I
wanted, and the result ended up being a simple delegation to an
un-persisted user object.

### Viewer

While the Viewer is basically a User, I didn't want to treat it that
way in the graph. I redid it so it's a set of connections to the key
items the client app is going to want to do.

### Connections

The connections concept from Relay is powerful in letting the client
dictate how it wants to gather associated information and enabling
pagination so as to not overwhelm either server or client.

### Resolvers

Re-reading the documentation, I think a better way to handle resolvers
that act more like decorators, or to do filtering, sorting, and
pagination, is to initialize the resolver with a base resolver proc,
as described in <http://graphql-ruby.org/fields/resolve_wrapper.html>.

This makes for a cleaner feel for the resolver wrapper.

For example, initially, I was using the following to format time
fields as iso8601 dates:

```ruby
module Resolvers
  class TimeFieldFormatter
    def initialize(field)
      @field = field
    end

    def call(object, _args, _context)
      time_field = object.public_send(@field)
      time_field.utc.iso8601(6) if time_field
    end
  end
end
```

and it would be called as:

```ruby
field :time_field, types.String do
  resolve Resolvers::TimeFieldFormatter.new(:time_field)
end
```

The resolve wrapper form looks a little different:

```ruby
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
```

and it is called like:

```ruby
  connection :my_posts, Edges::PostsWithPagination do
    argument :ids, types.String
    argument :title_contains, types.String
    argument :since, types.String
    argument :published_only, types.Boolean
    argument :drafs_only, types.Boolean
    argument :sort_by, types.String
    argument :direction, types.String
    argument :page, types.Int
    argument :per_page, types.Int
    resolve Resolvers::PostsResolver.new( ->(o,a,c) {o.posts} )
  end

  connection :public_posts, Edges::PostsWithPagination do
    argument :ids, types.String
    argument :title_contains, types.String
    argument :since, types.String
    argument :published_only, types.Boolean
    argument :drafs_only, types.Boolean
    argument :sort_by, types.String
    argument :direction, types.String
    argument :page, types.Int
    argument :per_page, types.Int
    resolve Resolvers::PostsResolver.new( ->(o,a,c) { Post.published })
  end
```

to give the Viewer two different sets of posts, one for the viewer
themselves, and the other all published posts.

The key thing is the resolver is initialized with a resolver proc,
kind of making the wrapper a high order function, or a decorator.

The first thing the resolver wrapper does inside it's `call` is to run
`call` on the wrapped resolver. The subsequent operations in the
wrapper modify the result.

## To do

I need to add a bunch of tests for the resolvers, which shouldn't be
too onerous as they're just POROs.

I need to create connections among the rest of the models, mainly
comments.

Still need to do more mutations to give the rest of the functionality
for the app.
