require('sinatra')
require('sinatra/reloader')
require('./lib/volunteer')
require('./lib/project')
also_reload('lib/**/*.rb')
require("pg")
require("pry")

DB = PG.connect({:dbname => "volunteer_tracker_test"})

get('/') do
  @project_input = Project.all
  erb(:index)
end

post('/new_title') do
  id = params['id']
  @title = params['title']
  new_title = Project.new({:id => id, :title => @title})
  new_title.save
  @project_input = Project.all()
  erb(:index)
end



get('/change_title/:id') do
  @project_input = Project.find(params.fetch("id").to_i())
  binding.pry
  erb(:title_form)
end


patch("/update/:id/edit") do
  @id = params['id']
  @title = params["title"]
  @project_input = Project.find(params.fetch("id").to_i())
  @project_input.update({:title => @title})
  redirect('/')
end

#
# post('/new_title2') do
#   id = params['id']
#   @title = params['title2']
#   new_title = Project.new({:id => id, :title => @title})
#   new_title.save
#   new_title.update
#   @project_input = Project.all()
#   erb(:detail)
# end
#
# get("/projects/:id/edit") do
#   @project_input = Project.find(params.fetch("id").to_i())
#   erb(:detail)
# end
#
# patch("/projects/:id") do
#   title = params.fetch("title")
#   @project_input = Project.find(params.fetch("id").to_i())
#   @project_input.update({:title => title})
#   erb(:detail)
# end
#
# delete("/projects/:id") do
#   @project_input = Project.find(params.fetch("id").to_i())
#   @project_input.delete()
#   @project_input = Project.all()
#   erb(:index)
# end
