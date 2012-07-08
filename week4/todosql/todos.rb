require './list.rb'

command = ARGV[0]
arguments = ARGV[1..-1]

@list = Todos::List.new

case command
  when '-h'
    puts "help yourself"
  when '-a'
    @list.add(arguments[0],arguments[1..-1].join(" "))
  when '-d'
    @list.delete(arguments.join(" "))
  when '-c'
    @list.complete!(arguments.join(" "))
  when '-r'
    @list.reorder(arguments[0],arguments[1])
  when '-s'
    @list.display_list
end