# This script converts a MIDI CSV file (.csv) to a Sonic Pi file (.rb):
# 1. Use MIDICSV to convert you MIDI file to a CSV file: https://www.fourmilab.ch/webtools/midicsv/
# 2. Run this script in Sonic Pi
# It worked for me with simple MIDI files, I can't guarantee that it will work with every MIDI files!

# For file_in and file_out you can use relative or absolute paths.
# If you use relative paths, on Windows Sonic Pi will look in your Desktop directory.
file_in = 'sonic-pi/file-in.csv'
file_out = 'sonic-pi/file-out.rb'

# If you prefer instructions like "play 60", set notes_as_letters to false.
# If you prefer instructions like "play :C4", set notes_as_letters to true.
notes_as_letters = true

# If notes_as_letters = true, you can change octave up or down when converting numbers to letters.
# Examples:
# octave_adjustment = 0 --> keep the same octave as in the input csv file
# octave_adjustment = 1 --> one octave upper than in the input csv file
# octave_adjustment = -2 --> two octaves lower than in the input csv file
octave_adjustment = 0

# Timing/tempo is tricky in MIDI files, I do not fully understand how it works...
# If the generated .rb file is too slow or too fast, you can adjust it here.
# Examples:
# timing_adjustment = 1 --> default value
# timing_adjustment = 2 --> 2 times faster
# timing_adjustment = 0.25 --> 4 times slower
timing_adjustment = 1

default_synth = ':piano'
default_bpm = 120

division = 1
track = 0
time = 0
events = []

define :to_int_if_is_int do |number|
  return number == number.to_i ? number.to_i : number
end

File.foreach(file_in) { |str_line|
  cur_line = str_line.strip.split(', ')
  cur_track = cur_line[0].to_i
  cur_time = cur_line[1].to_f / timing_adjustment / division # time in MIDI clocks converted to beat time
  if track == cur_track
    if track == 0
      division = cur_line[5].to_i
    else
      case cur_line[2]
      when 'Tempo'
        bpm = 60000000 / cur_line[3].strip.to_i
        events[track].append(['use_bpm', bpm])
      when 'Note_on_c'
        cur_key = cur_line[4].to_i
        if cur_time > time
          events[track].append(['sleep', to_int_if_is_int(cur_time - time)])
          time = cur_time
        end
        index = events[track].size # index will be used to find and modify this element in Note_off_c event
        events[track].append(["play_#{cur_key}", cur_time, index])
      when 'Note_off_c'
        cur_key = cur_line[4].to_i
        start_time = events[track].assoc("play_#{cur_key}")[1]
        index = events[track].assoc("play_#{cur_key}")[2]
        events[track][index] = ['play', cur_key, to_int_if_is_int(cur_time - start_time)]
      end
    end
  else
    track = cur_track
    time = 0
    events[track] = []
  end
}

define :to_letter do |number|
  notes = ['C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab', 'A', 'Bb', 'B']
  return ":#{notes[(number%12)]}#{(number/12).floor-1+octave_adjustment}"
end

define :writeln do |line|
  File.write(file_out, "#{line}\n", mode: 'a')
end

File.write(file_out, "use_bpm #{default_bpm}")
writeln('')
events.each do |track|
  if track != []
    writeln('')
    writeln('in_thread do')
    writeln("  use_synth #{default_synth}")
    track.each do |event|
      event[1] = event[0]=='play' && notes_as_letters ? to_letter(event[1]) : event[1]
      release = event[2]!=nil ? ", release: #{event[2]}" : ''
      writeln("  #{event[0]} #{event[1]}#{release}")
    end
    writeln('end')
  end
end
