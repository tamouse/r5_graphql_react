Edges::UsersWithPagination = Types::UserType.define_connection do
  name "UsersWithPagination"

  field :totalCount,  types.Int do
    resolve ->(o, _a, _c) {o.nodes.count}
  end
  field :currentPage, types.Int do
    resolve ->(o, _a, _c) {o.nodes.current_page}
  end
  field :nextPage,    types.Int do
    resolve ->(o, _a, _c) {o.nodes.next_page}
  end
  field :prevPage,    types.Int do
    resolve ->(o, _a, _c) {o.nodes.prev_page}
  end
end
