class Search
  def initialize(search_term: nil, model: nil, tag_list: nil, institutions: nil)
    @search_term = search_term
    @tags = tag_list
    @institutions = institutions
    @model = model
  end

  def search
    PeopleSearch.new(search_term: @search_term, tags: @tags, institutions: @institutions).search
  end

end
