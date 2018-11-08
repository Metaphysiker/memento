class Search
  include ApplicationHelper

  def initialize(search_term: nil, model: "Person", tag_list: nil, institutions: nil, assigned_to_user_id: nil, page: 0)
    @search_term = search_term
    @tags = tag_list
    @institutions = institutions
    @model = model
    @assigned_to_user_id = assigned_to_user_id
    @page = page
    @records = []
  end

  def search
    klass = class_for(@model)
    #klass = @model

    if klass == Person
      @records = PeopleSearch.new(search_term: @search_term, tags: @tags, institutions: @institutions).search
      @records = @records.order(:name).page(@page).per(20)
    elsif klass == Institution
      @records = InstitutionsSearch.new(search_term: @search_term, tags: @tags, institutions: @institutions).search
      @records = @records.order(:name).page(@page).per(20)
    elsif klass == Note
      @records = NotesSearch.new(search_term: @search_term, tags: @tags, institutions: @institutions).search
      @records = @records.order(:created_at).reverse_order.page(@page).per(20)
    elsif klass == Task
      @records = TasksSearch.new(search_term: @search_term, tags: @tags, institutions: @institutions, assigned_to_user_id: @assigned_to_user_id).search
      @records = @records.order(:created_at).reverse_order.page(@page).per(20)
    end
    byebug
  end

  def return_search_inputs
    OpenStruct.new(search_term: @search_term, tags: @tags, institutions: @institutions, model: @model)
  end
end
