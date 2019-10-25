class BlogsSearch
  def initialize(search_term: nil)
    @search_term = search_term
  end

  def search
  query = Blog.all

  unless @search_term.nil? || @search_term.blank?
    query = query.search_records_ilike("%#{@search_term}%")
  end

    query.distinct
  end
end
