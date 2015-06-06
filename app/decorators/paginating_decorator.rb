class PaginatingDecorator < Draper::CollectionDecorator
  # support for kaminari
  delegate :current_page, :total_pages, :limit_value, :total_count, :pluck, :any
end
