def add_tag_to_functionalities(original_tag, new_tag)
  Person.tagged_with(original_tag, :on => :target_groups).each do |p|
    p.functionality_list.add(new_tag)
    p.save
  end
end

array_of_tags = [
  ["Uni-Mitarbeitende", "Uni-Mitarbeitende"],
  ["Gymnasiallehrperson", "Lehrperson"],
  ["Medienfachleute", "Medienfachleute"],
  ["Blogger(Zielgruppe)", "Blogger"],
  ["SNF", "SNF"]
]

array_of_tags.each do |array_tag|
  add_tag_to_functionalities(array_tag[0], array_tag[1])
end
