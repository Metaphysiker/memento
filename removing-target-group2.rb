def add_tag_to_functionalities(original_tag, new_tag)
  Institution.tagged_with(original_tag, :on => :target_groups).each do |p|
    p.functionality_list.add(new_tag)
    p.save
  end
end

array_of_tags = [
  ["Medienkontakt(Zielgruppe)", "Medienkontakt"],
  ["Kooperationspartner(Zielgruppe)", "Kooperationspartner"],
  ["Stiftung(Zielgruppe)", "Stiftung"],
  ["Philosophische-Institution(Zielgruppe)", "Philosophische-Institution"],
  ["Gymnasium(Zielgruppe)", "Gymnasium"],
  ["Philosophisches-Cafe(Zielgruppe)", "Philosophisches-Cafe"],
  ["Philosophische-Praxis(Zielgruppe)", "Philosophische-Praxis"]
]

array_of_tags.each do |array_tag|
  add_tag_to_functionalities(array_tag[0], array_tag[1])
end
