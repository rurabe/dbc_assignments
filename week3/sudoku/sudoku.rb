class Cell
  attr_accessor :contents, :impossible_values, :possible_values
  attr_reader :id
  @@counter = 0
  def initialize(value)
    @contents = value
    @id = @@counter
    @@counter += 1
    @impossible_values = []
    @possible_values = []
  end

  def reset
    @@counter = 0
  end
end

class Row
  attr_accessor :contents
  attr_reader :id
  @@counter = 0
  def initialize
    @contents = []
    @id = @@counter
    @@counter += 1
  end

  def reset
    @@counter = 0
  end
end

class Column
  attr_accessor :contents
  attr_reader :id
  @@counter = 0
  def initialize
    @contents = []
    @id = @@counter
    @@counter += 1
  end

  def reset
    @@counter = 0
  end
end

class Box
  attr_accessor :contents
  attr_reader :id, :contents
  @@counter = 0
  def initialize
    @contents = []
    @id = @@counter
    @@counter += 1
  end

  def reset
    @@counter = 0
  end
end

class Board
  attr_reader :cells, :rows, :columns, :boxes
  @@counter = 0
  def initialize(input_values)
    @input_value = input_values.to_s.split("")
    @cells = []
    @rows = []
    @columns = []
    @boxes = []
    Cell.new("0").reset
    Row.new.reset
    Column.new.reset
    Box.new.reset
    @id = @@counter
    @@counter += 1
    self.create_cells
    self.create_rows
    self.create_columns
    self.create_boxes
  end
 
  def create_cells
    @input_value.each { |value| @cells << Cell.new(value) }
  end

  def create_rows
    9.times do |row|
      @rows << Row.new
    end
    self.populate_rows
  end

  def create_columns
    9.times do |row|
      @columns << Column.new
    end
    self.populate_columns
  end
  
  def create_boxes
    9.times do |boxes|
      @boxes << Box.new
    end
    self.populate_boxes
  end
  
  def populate_rows
    @cells.each do |cell|
      select_row(cell.id).contents << cell
    end
  end
  
  def populate_columns
    @cells.each do |cell|
      select_column(cell.id).contents << cell
    end
  end

  def populate_boxes
    @cells.each do |cell|
      select_box(cell.id).contents << cell
    end
  end
  
  def view
    @rows.each do |row|
      puts "#{row.contents[0].contents} #{row.contents[1].contents} #{row.contents[2].contents} | #{row.contents[3].contents} #{row.contents[4].contents} #{row.contents[5].contents} | #{row.contents[6].contents} #{row.contents[7].contents} #{row.contents[8].contents}"
    end
  end

  def print
    self.cells.map {|cell| cell.contents}.join("")
  end

  def select_row(cell_id)
    @rows.find {|row| row.id == cell_id/9}
  end

  def select_column(cell_id)
    @columns.find {|column| column.id == cell_id%9}
  end

  def select_box(cell_id)
    @boxes.find {|box| ((cell_id%9)/3) + (cell_id/27)*3 == box.id }
  end

  def populate_impossible_values(cell_id)
    cell = @cells.find {|c| c.id == cell_id }
    #for rows
    select_row(cell_id).contents.each do |row_cell|
      cell.impossible_values << row_cell.contents
    end
    #for columns
    select_column(cell_id).contents.each do |col_cell|
      cell.impossible_values << col_cell.contents
    end
    #for boxes
    select_box(cell_id).contents.each do |box_cell|
      cell.impossible_values << box_cell.contents
    end
    cell.impossible_values.uniq!.delete("0")
  end

  def populate_possible_values(cell_id)
    cell = @cells.find {|c| c.id == cell_id }
    all_values = (1..9).to_a.map(&:to_s)
    cell.possible_values = all_values - cell.impossible_values
  end

  def select_unsolved_row_peers(cell_id)
    unsolved_row_cells = select_row(cell_id).contents.select {|r_cell| r_cell.contents == "0" && r_cell.id != cell_id}
    common_impossibles = unsolved_row_cells.inject((1..9).to_a.map(&:to_s)) {|result,item| result = result & item.impossible_values }
    common_impossibles - select_solved_row_peers(cell_id).map {|cell| cell.contents}  
  end
  
  def select_unsolved_column_peers(cell_id)
    unsolved_column_cells = select_column(cell_id).contents.select {|c_cell| c_cell.contents == "0" && c_cell.id != cell_id}
    common_impossibles = unsolved_column_cells.inject((1..9).to_a.map(&:to_s)) {|result,item| result = result & item.impossible_values }
    common_impossibles - select_solved_column_peers(cell_id).map {|cell| cell.contents}
  end  
  
  def select_unsolved_box_peers(cell_id)
    unsolved_box_cells = select_box(cell_id).contents.select {|b_cell| b_cell.contents == "0" && b_cell.id != cell_id}
    common_impossibles = unsolved_box_cells.inject((1..9).to_a.map(&:to_s)) {|result,item| result = result & item.impossible_values }
    common_impossibles - select_solved_box_peers(cell_id).map {|cell| cell.contents}
  end
  
  def select_solved_row_peers(cell_id)
    select_row(cell_id).contents.select {|r_cell| r_cell.contents != "0"}
  end
  
  def select_solved_column_peers(cell_id)
    select_row(cell_id).contents.select {|c_cell| c_cell.contents != "0"}
  end  
  
  def select_solved_box_peers(cell_id)
    select_box(cell_id).contents.select {|b_cell| b_cell.contents != "0"}
  end
  
  def populate_peer_impossibles(cell_id)
    select_row(cell_id).contents.select {|r_cell| r_cell.contents == "0"}
  end
  
  #Solving strategies  
  
  def evaluate_each_cell
    @cells.each do |cell|
      populate_impossible_values(cell.id)
      populate_possible_values(cell.id)
      if cell.possible_values.size == 1 && cell.contents == "0"
        cell.contents = cell.possible_values[0]
      end
    end
  end
  
  def check_peers_mutual_impossibles
    puts "hard one eh?"
    @cells.each do |cell|
      if self.select_unsolved_row_peers(cell.id).size == 1
        cell.contents = select_unsolved_row_peers(cell.id)[0]
        self.loop_evaluation &method(:evaluate_each_cell)
      elsif self.select_unsolved_column_peers(cell.id).size == 1
        cell.contents = select_unsolved_column_peers(cell.id)[0]
        self.loop_evaluation &method(:evaluate_each_cell)
      elsif self.select_unsolved_box_peers(cell.id).size == 1
        cell.contents = select_unsolved_box_peers(cell.id)[0]
        self.loop_evaluation &method(:evaluate_each_cell)
      end
    end
    self.evaluate_each_cell
  end  

  def loop_evaluation(&strategy)
    old = nil
    current = self.print
    while old != current
      strategy.call
      old = current
      current = self.print
    end
  end
  
  #Overarching solver method
  def solve
    self.loop_evaluation &method(:evaluate_each_cell)
    if self.print.include?("0")
      #self.loop_evaluation &method(:check_peers_mutual_impossibles)
    end
    unless self.print.include?("0")
      self.view
      self.print
    end
  end
end



