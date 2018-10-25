class TasksSearch
  def initialize(search_term: nil, tags: nil, institutions: nil, assigned_to_user_id: nil)
    @search_term = search_term
    @tags = tags
    @institutions = institutions
    @assigned_to_user_id = assigned_to_user_id
  end

  def search
  query = Task.all

  unless @search_term.nil? || @search_term.blank?
    query = query.search_records_ilike("%#{@search_term}%")
  end

  unless @assigned_to_user_id.nil? || @assigned_to_user_id.blank?
    query = query.where(assigned_to_user_id: @assigned_to_user_id)
  end
=begin
  unless @institutions.nil? || @institutions.empty?
    institutions = @institutions.reject { |c| c.blank? }
    institutions = institutions.collect {|x| x.to_i}

    unless institutions.empty?
      query = query.includes(:institutions).where(institutions: {id: institutions})
    end

  end

  unless @tags.nil? || @tags.empty?
    tags = @tags.reject { |c| c.blank? }
    unless tags.empty?
      query = query.tagged_with(tags)
    end
  end
=end
    query.distinct
  end
end
