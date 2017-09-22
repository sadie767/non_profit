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
  return_title.each() do |title|
  id = project.fetch('id').to_i
  title = project.fetch('title')
  title_arrays.push(Project.new({:id => id, :title => title}))
end
  return title_arrays
end


  def ==(another_list)
    (self.title.==another_list.title).&(self.id.==another_list.id)
  end

end
