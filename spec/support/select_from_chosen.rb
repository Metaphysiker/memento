# spec/support/select_from_chosen.rb
module SelectFromChosen
  # select_from_chosen('Option', from: 'id_of_field')
  def select_from_chosen(item_text, options)
    field = find_field(options[:from], :visible => false)
    find("##{field[:id]}_chosen").click
    sleep 0.5
    find("##{field[:id]}_chosen ul.chosen-results li", :text => item_text).click
    sleep 0.5
  end

  def remove_from_chosen(item_text, options)
    field = find_field(options[:from], :visible => false)

    find("##{field[:id]}_chosen ul.chosen-choices li", :text => item_text)
    if page.has_css?("##{field[:id]}_chosen ul.chosen-choices li", :text => item_text)
      within first("##{field[:id]}_chosen ul.chosen-choices li", :text => item_text) do
        find("a.search-choice-close").click
      end
    end
  end
end
