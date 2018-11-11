class PeopleSearch
  def initialize(search_term: nil, tags: nil, institutions: nil)
    @search_term = search_term
    @tags = tags
    @institutions = institutions
  end

  def search
  query = Person.all

  unless @search_term.nil? || @search_term.blank?
    query = query.search_records_ilike("%#{@search_term}%")
  end

  unless @institutions.nil? || @institutions.empty?
    institutions = @institutions.reject { |c| c.blank? }
    institutions = institutions.collect {|x| x.to_i}
    ids_of_people_with_institutions = Person.all.pluck(:id)

    unless institutions.empty?
      institutions.each do |institution|
        ids = Person.all.includes(:institutions).where(institutions: {id: institution}).pluck(:id)
        ids_of_people_with_institutions = ids_of_people_with_institutions & ids
      end
      query = query.where(id: ids_of_people_with_institutions)
    end

=begin
    unless institutions.empty?
      query = query.includes(:institutions).where(institutions: {id: institutions})
    end
=end
  end



  unless @tags.nil? || @tags.empty?
    tags = @tags.reject { |c| c.blank? }
    unless tags.empty?
      query = query.tagged_with(tags)
    end
  end

    query.distinct
  end
end
