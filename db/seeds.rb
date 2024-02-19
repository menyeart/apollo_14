modifier = [1,2,3,4,5]

modifier.each do |num|
  Astronaut.create!(name: "matt#{num}", age: 10 + num, job: "Moonperson #{num}")
end

