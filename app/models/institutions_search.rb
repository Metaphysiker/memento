class InstitutionsSearch
  def initialize(search_term: nil, tags: nil, functionalities: nil, target_groups: nil, institutions: nil)
    @search_term = search_term
    @tags = tags
    @institutions = institutions
    @target_groups = target_groups
    @functionalities = functionalities
  end

  def search
  query = Institution.all

  unless @search_term.nil? || @search_term.blank?
    query = query.search_records_ilike("%#{@search_term}%")
  end

  unless @institutions.nil? || @institutions.empty?
    institutions = @institutions.reject { |c| c.blank? }
    institutions = institutions.collect {|x| x.to_i}

    unless institutions.empty?
      query = query.where(institutions: {id: institutions})
    end
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
