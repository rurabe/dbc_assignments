require File.expand_path("../classes.rb",__FILE__)

command = ARGV[0]
argument = ARGV[1..-1].join(" ")

doc = "     Options:
            -h --help            show this help message and exit
            -a --add [task]      add a task to the list      
            -r --reorder         move a task to another spot on the list
            -c --complete        mark a task complete
            -d --delete          delete a task
            -t --tag [tag]       tag a task
            -l --list            show all tasks by creation date
            -f --finished        show completed tasks by completion date
            -g --taGs [tags]     list tasks with one or more tags
            -p --priority        retreive a task with a specific priority
            "

list = Todo::List.new

case command
  when '-h'
    puts doc
  when '-a'
    list.add(argument)
  when '-r'
    list.reorder
  when '-c'
    list.mark_complete
  when '-d'
    list.delete
  when '-t'
    list.tag_task(argument)
  when '-l'
    list.display_tasks
  when '-e'
    list.display_by_creation_date
  when '-f'
    list.display_by_completion_date
  when '-g'
    list.search_by_tags(argument)
  when '-p'
    list.search_by_priority(argument)
  end

list.write