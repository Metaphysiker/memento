class PeopleSearch
  def initialize(selection: nil, search_term: nil, tags: nil, institutions: nil, functionalities: nil, target_groups: nil)
    @selection = selection
    @search_term = search_term
    @tags = tags
    @institutions = institutions
    @target_groups = target_groups
    @functionalities = functionalities
  end

  def search
    query = Person.all

  unless @selection.nil? || @selection.blank?
    selection = @selection.split
    query = query.where(id: selection)
    byebug
  end

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


=begin
  unless @tags.nil? || @tags.empty?
    tags = @tags.reject { |c| c.blank? }
    unless tags.empty?
      query = query.tagged_with(tags)
    end
  end
=end

  unless @functionalities.nil? || @functionalities.empty?
    tags = @functionalities.reject { |c| c.blank? }
    unless tags.empty?
      query = query.tagged_with(tags, :on => :functionalities)
    end
  end

  unless @target_groups.nil? || @target_groups.empty?
    tags = @target_groups.reject { |c| c.blank? }
    unless tags.empty?
      query = query.tagged_with(tags, :on => :target_groups)
    end
  end

    query.distinct
  end
end
