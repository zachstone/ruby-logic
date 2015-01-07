def not?(x)
  # 0|1
  # 1|0
  !x
end

def and?(x, y)
  # 0|0|0
  # 0|1|0
  # 1|1|1
  x && y
end

def or?(x, y)
  # 0|0|0
  # 0|1|1
  # 1|1|1
  x || y
end

def nand?(x, y)
  # 0|0|1
  # 0|1|1
  # 1|1|0
  !(x && y)
  # !x || !y
end

def nor?(x, y)
  # 0|0|1
  # 0|1|0
  # 1|1|0
  !(x || y)
end

def xor?(x, y)
  # 0|0|0
  # 0|1|1
  # 1|1|0
  x != y
end

def xnor?(x, y)
  # 0|0|1
  # 0|1|0
  # 1|1|1
  x == y
end

def probe2(func)
  puts "  i   |   i   |   o"
  puts "false | false | #{send(func, false, false)}"
  puts "false | true  | #{send(func, false, true)}"
  puts "true  | true  | #{send(func, true, true)}"
end