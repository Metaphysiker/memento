class PeopleSearch
  def initialize(groups: nil, selection: nil, search_term: nil, tags: nil, institutions: nil, functionalities: nil, target_groups: nil, topics: nil, language: nil, paid: nil, paid_year: nil, country: nil)
    @groups = groups
    @selection = selection
    @search_term = search_term
    @tags = tags
    @institutions = institutions
    @target_groups = target_groups
    @functionalities = functionalities
    @topics = topics
    @language = language
    @paid = paid
    @paid_year = paid_year
    @country = country
  end

  def search
    query = Person.all

  unless @selection.nil? || @selection.blank?
    query = query.where(id: @selection)
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

  unless @topics.nil? || @topics.empty?
    topics = @topics.reject { |c| c.blank? }
    topics = topics.collect {|x| x.to_i}
    ids_of_people_with_topics = Person.all.pluck(:id)

    unless topics.empty?
      topics.each do |topic|
        ids = Person.all.includes(:topics).where(topics: {id: topic}).pluck(:id)
        ids_of_people_with_topics = ids_of_people_with_topics & ids
      end
      query = query.where(id: ids_of_people_with_topics)
    end
  end

  unless @groups.nil? || @groups.empty?
    groups = @groups.reject { |c| c.blank? }
    groups = groups.collect {|x| x.to_i}
    ids_of_people_with_groups = Person.all.pluck(:id)

    unless groups.empty?
      groups.each do |group|
        ids = Person.all.includes(:groups).where(groups: {id: group}).pluck(:id)
        ids_of_people_with_groups = ids_of_people_with_groups & ids
      end
      query = query.where(id: ids_of_people_with_groups)
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

  unless @language.nil? || @language.blank?
    query = query.where(language: @language)
  end

  unless @paid.nil? || @paid.blank?

    if @paid_year.nil? || @paid_year.blank?
      ids_of_people_who_have_paid = Payment.where(paymentable_type: "Person").pluck(:paymentable_id)
    else
      ids_of_people_who_have_paid = Payment.where(paymentable_type: "Person").where(date: Date.parse("#{@paid_year}-01-01").beginning_of_year..Date.parse("#{@paid_year}-01-01").end_of_year).pluck(:paymentable_id)
    end

    #byebug
    if @paid == "yes"
      ids = ids_of_people_who_have_paid
    else
      ids = Person.all.pluck(:id) - ids_of_people_who_have_paid
    end
    #byebug
    query = query.where(id: ids)
  end

  unless @country.nil? || @country.blank?

    ids_of_people_in_country = Person.joins(:address).where(addresses: {country: @country}).pluck(:id)

    query = query.where(id: ids_of_people_in_country)

    #byebug

  end

    query.distinct
  end
end
