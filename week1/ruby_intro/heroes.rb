class Hero
  attr_accessor :life, :level

  def initialize(level)
    if level > 100 || level <1
      raise "invalid level"
    else @level = level
    end
    @life = 100*level
  end

  def name
    "Hero #{@name.capitalize} the #{@class}"
  end
end

class Human < Hero
  def initialize(level,name)
    super level
    @name = name
    @class = "Human"
  end

  def name
    super
  end
end

class Night_elf < Hero
  def initialize(level,name)
    super level
    @name = name
    @class = "Night Elf"
  end

  def name
    super
  end
end

class Orc < Hero
  def initialize(level,name)
    super level
    @name = name
    @class = "Orc"
  end

  def name
    super
  end
end