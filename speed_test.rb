require "benchmark"
 
time = Benchmark.realtime do
  for rep in 0..10 do
    buffer = Array.new(320*240)
    for i in 0..320
      for j in 0..240
        buffer[j * 320 + i] = (i + j) << 16 + i << 8 + j
      end
    end
  end
end
puts "Time elapsed #{time*1000} ms"

time = Benchmark.realtime do
  for rep in 0..10 do
    buffer = ""
    for i in 0..320
      for j in 0..240
        buffer << 0
        buffer << 0
        buffer << i % 255
        buffer << j % 255
      end
    end
  end
end
puts "Time elapsed #{time*1000} ms"

color = ""
color << 0
color << 64
color << 128
color << 192

time = Benchmark.realtime do
  for rep in 0..10 do
    buffer = ""
    for i in 0..320
      for j in 0..240
        buffer.concat(color)
      end
    end
  end
end
puts "Time elapsed #{time*1000} ms"

zerocolor = ""
zerocolor << 0
zerocolor = zerocolor * 4
empty_buffer = zerocolor * (320 * 240)

time = Benchmark.realtime do
  for rep in 0..10 do
    buffer = String.new(empty_buffer)
    for i in 0...(320*240)
      bo = i * 4
      buffer.setbyte(bo, 0)
      buffer.setbyte(bo + 1, 64)
      buffer.setbyte(bo + 2, 64)
      buffer.setbyte(bo + 3, 64)
    end
  end
end
puts "Time elapsed #{time*1000} ms"

require_relative 'ext/my_test'
color = 0x00aa4455
buffer = String.new(empty_buffer)
top = 320*240
time = Benchmark.realtime do
  for rep in 0..100 do
    for i in 0...top
      buffer.fast_word(i, color)
    end
    buffer.mark_modify
  end
end
puts "Time elapsed #{time*1000} ms (100 reps)"


color = 0x00aa4455
buffer = String.new(empty_buffer)
top = 320*240
time = Benchmark.realtime do
  rep = 0
  while rep < 100
    i = 0
    while i < top
      buffer.fast_word(i, color)
      i += 1
    end
    buffer.mark_modify
    rep += 1
  end
end
puts "Time elapsed #{time*1000} ms (100 reps)"











