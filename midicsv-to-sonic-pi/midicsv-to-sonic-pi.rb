default_synth = ':piano'
default_bpm = 120
bpm = default_bpm
track = 0
time = 0
keys_time = []
events = []

file_in = 'sonic-pi/file-in.csv'
File.foreach(file_in) { |str_line|
  cur_line = str_line.strip.split(', ')
  cur_track = cur_line[0].to_i
  cur_time = cur_line[1].to_f / 1024 #time in MIDI clocks converted to beat time
  if track == cur_track
    
    case
    when track == 1
      if cur_line[2] == 'Tempo'
        bpm = cur_line[3].strip.to_i * 120 / 500000
      end
      
    when track > 1
      
      case cur_line[2]
      when 'Note_on_c'
        cur_key = cur_line[4].to_i
        if cur_time > time
          events[track].append(['sleep', cur_time - time])
          time = cur_time
        end
        index = events[track].size # index will be used to find and modify this element in Note_off_c event
        events[track].append(["play_#{cur_key}", cur_time, index])
        
        
      when 'Note_off_c'
        cur_key = cur_line[4].to_i
        start_time = events[track].assoc("play_#{cur_key}")[1]
        index = events[track].assoc("play_#{cur_key}")[2]
        events[track][index] = ['play', cur_key, cur_time - start_time]
        
      end
      
    end
    
  else
    track = cur_track
    time = 0
    events[track] = []
  end
}

file_out = 'sonic-pi/file-out.rb'
define :writeln do |line|
  File.write(file_out, "#{line}\n", mode: 'a')
end

File.write(file_out, "use_bpm #{bpm}")
writeln('')
events.each do |track|
  if track != []
    writeln('')
    writeln('in_thread do')
    writeln("  use_synth #{default_synth}")
    track.each do |event|
      case event[0]
      when 'play'
        writeln("  play #{event[1]}, release: #{event[2]}")
        
      when 'sleep'
        writeln("  sleep #{event[1]}")
        
      end
    end
    writeln('end')
  end
end
