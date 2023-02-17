# For file_in and file_out you can use relative or absulte paths.
# If you use relative paths, on Windows Sonic Pi will look in your Desktop directory.
file_in = 'sonic-pi/file-in.csv'
file_out = 'sonic-pi/file-out.rb'

# If you prefer instructions like "play 60", set notes_as_letters to false.
# If you prefer instructions like "play :C4", set notes_as_letters to true.
notes_as_letters = true

default_synth = ':piano'
default_bpm = 120

bpm = default_bpm
track = 0
time = 0
events = []

File.foreach(file_in) { |str_line|
  cur_line = str_line.strip.split(', ')
  cur_track = cur_line[0].to_i
  cur_time = cur_line[1].to_f / 1024 # time in MIDI clocks converted to beat time
  if track == cur_track
    if track == 1
      if cur_line[2] == 'Tempo'
        bpm = 60000000 / cur_line[3].strip.to_i
      end
    elsif track > 1
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

define :number_to_letter do |i|
  notes = ['C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab', 'A', 'Bb', 'B']
  return ":#{notes[(i%12)]}#{(i/12).floor-1}"
end

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
      event[1] = event[0]=='play' && notes_as_letters ? number_to_letter(event[1]) : event[1]
      release = event[2]!=nil ? ", release: #{event[2]}" : ''
      writeln("  #{event[0]} #{event[1]}#{release}")
    end
    writeln('end')
  end
end
