class Project

attr_reader :id
attr_accessor :title

def initialize(attr)
  @id = attr.fetch(:id)
  @title = attr.fetch(:title)
end

def save
  result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') returning id;")
  @id = result.first().fetch('id').to_i()
end

def self.all
  return_title = DB.exec('SELECT * FROM projects;')
  title_arrays = []
  return_title.each() do |item|
    id = item.fetch('id').to_i
    title = item.fetch('title')
    title_arrays.push(Project.new({:id => id, :title => title}))
  end
    title_arrays
end


  def ==(another_project)
    (self.title.==another_project.title).&(self.id.==another_project.id)
  end

  def self.find(id)
    id_finder = nil
    Project.all().each() do |item|
      if item.id().==(id)
        id_finder = item
      end
    end
    id_finder
  end

#   def volunteer
#     all_volunteers = nil
#     select_volunteers = ('SELECT * FROM projects
# JOIN volunteers ON (volunteers.project_id = projects.id)
# WHERE projects.id = 1;')
#     select_volunteers.all().each() do |item|
#       if item.project_id().==(id)
#         all_volunteers = item
#       end
#     end
#     all_volunteers
#   end

def update
  update_projects = DB.exec("UPDATE projects SET title = 'Teaching Ruby to kids' WHERE id = 1;")
end

def delete
  delete_projects = DB.exec('DELETE FROM projects WHERE id = 1;')
  @id = delete_projects.first().fetch('id').to_i()
end

end
