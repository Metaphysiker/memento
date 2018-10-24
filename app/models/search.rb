class Search
  def initialize(search_term: nil, model: nil, tag_list: nil, institutions: nil)
    @search_term = search_term
    @tags = tag_list
    @institutions = institutions
    @model = model
    @records = []
  end

  def search
    klass = class_for(@model)

    if klass == Person
      @records = PeopleSearch.new(search_term: search_term, tags: tags, institutions: institutions).search
      @records = @records.order(:name).page(params[:page]).per(20)
    elsif klass == Institution
      @records = klass.search_records_ilike("%#{search_term}%")
      @records = @records.order(:name).page(params[:page]).per(20)
    elsif klass == Note
      @records = klass.search_records_ilike("%#{search_term}%")
      @records = @records.order(:created_at).reverse_order.page(params[:page]).per(20)
    else
      @records = klass.search_records_ilike("%#{search_term}%")
      @records = @records.order(:created_at).reverse_order.page(params[:page]).per(20)
    end
  end

  def return_search_inputs
    OpenStruct.new(search_term: @search_term, tags: @tags, institutions: @institutions, model: @model)
  end

  def returnnewclass
    PeopleSearch.new(search_term: "Man")
  end

end
