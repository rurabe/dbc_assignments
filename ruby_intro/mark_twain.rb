class String
  def mark_twain(a=[])
    if self.split.length > 1
      a << "Draft: #{self}"
      p a
      new_draft = self.split[0..2]
      new_draft.join(' ').mark_twain(a)
    else
      a << "Final Draft: #{self}"
    end
    a
  end
end

p "hey how are you".mark_twain