in_thread do
  loop do
    use_synth :fm
    play 40, release: 0.2, amp: 5
    sleep 1
  end
end