Person.all.each do |p|
  p.functionality_list.add(TagList.where(model: "Person", category: "functionality").sample.name)
  p.target_group_list.add(TagList.where(model: "Person", category: "target_group").sample.name)
  p.save
end

Institution.all.each do |p|
  p.functionality_list.add(TagList.where(model: "Institution", category: "functionality").sample.name)
  p.target_group_list.add(TagList.where(model: "Institution", category: "target_group").sample.name)
  p.save
end


heroku pg:push memento_development postgresql-elliptical-88337 --app mement0
