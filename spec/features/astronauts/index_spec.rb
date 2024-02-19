require "rails_helper"

RSpec.describe "Astronauts Index Page" do
  it "As a visitor, When I visit the Astronauts index page ('/astronauts') I see a list of astronauts with the following info: - Name, - Age, - Job " do
    matt = Astronaut.create!(name: "Matt", age: 12, job: "Spaceman")
    kara = Astronaut.create!(name: "Kara", age: 14, job: "Spacegorlmoonrockcollecter")

    visit "/astronauts"

    expect(page).to have_content("Name: Matt, Age: 12, Job: Spaceman")
    expect(page).to have_content("Name: #{kara.name}, Age: #{kara.age}, Job: #{kara.job}")
  end

  it "As a visitor, When I visit the Astronauts index page (/astronauts') I see the average age of all astronauts." do
    matt = Astronaut.create!(name: "Matt", age: 12, job: "Spaceman")
    kara = Astronaut.create!(name: "Kara", age: 14, job: "Spacegorlmoonrockcollecter")

    visit "/astronauts"
    expect(page).to have_content("Average Age: 13")
  end

  it "As a visitor, When I visit the Astronauts index page ('/astronauts'), I see a list of the space missions' in alphabetical order for each astronaut.." do

    matt = Astronaut.create!(name: "Matt", age: 12, job: "Spaceman")
    kara = Astronaut.create!(name: "Kara", age: 14, job: "Spacegorlmoonrockcollecter")

    apollo = Mission.create!(title: "Apollo 13", time_in_space: 12)
    capricorn = Mission.create!(title: "Capricorn 4", time_in_space: 20)
    gemini = Mission.create!(title: "Gemini 7", time_in_space: 5)

    ast_space = AstronautMission.create!(astronaut_id: matt.id, mission_id: apollo.id)
    ast_space1 = AstronautMission.create!(astronaut_id: matt.id, mission_id: capricorn.id)
    ast_space2 = AstronautMission.create!(astronaut_id: matt.id, mission_id: gemini.id)

    ast_space3 = AstronautMission.create!(astronaut_id: kara.id, mission_id: apollo.id)
    ast_space4 = AstronautMission.create!(astronaut_id: kara.id, mission_id: capricorn.id)

    visit "/astronauts"

    expect(page).to have_content("Matt's Space Missions: Apollo 13, Capricorn 4, Gemini 7")
    expect(page).to have_content("Kara's Space Missions: Apollo 13, Capricorn 4")
  end

  it "As a visitor, When I visit the Astronauts index page ('astronauts')I see the total time in space for each astronaut"  do

    matt = Astronaut.create!(name: "Matt", age: 12, job: "Spaceman")
    kara = Astronaut.create!(name: "Kara", age: 14, job: "Spacegorlmoonrockcollecter")

    apollo = Mission.create!(title: "Apollo 13", time_in_space: 12)
    capricorn = Mission.create!(title: "Capricorn 4", time_in_space: 20)
    gemini = Mission.create!(title: "Gemini 7", time_in_space: 5)

    ast_space = AstronautMission.create!(astronaut_id: matt.id, mission_id: apollo.id)
    ast_space1 = AstronautMission.create!(astronaut_id: matt.id, mission_id: capricorn.id)
    ast_space2 = AstronautMission.create!(astronaut_id: matt.id, mission_id: gemini.id)

    ast_space3 = AstronautMission.create!(astronaut_id: kara.id, mission_id: apollo.id)
    ast_space4 = AstronautMission.create!(astronaut_id: kara.id, mission_id: capricorn.id)

    visit "/astronauts"

    expect(page).to have_content("Matt's Total Time in Space: 37 days")
    expect(page).to have_content("Kara's Total Time in Space: 32 days")
  end
end