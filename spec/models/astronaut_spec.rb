require 'rails_helper'

describe Astronaut, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :job }
  end

  describe 'Relationships' do
    it { should have_many :astronaut_missions}
    it { should have_many :missions}
  end

  describe 'Methods' do
    it "can determine the average age of all astronauts" do
      matt = Astronaut.create!(name: "Matt", age: 12, job: "Spaceman")
      kara = Astronaut.create!(name: "Kara", age: 14, job: "Spacegorlmoonrockcollecter")

      expect(Astronaut.avg_age).to eq(13)

      gilbert = Astronaut.create!(name: "Gilbert", age: 10, job: "Spacenakeholemoonexploreboi")

      expect(Astronaut.avg_age).to eq(12)
    end

    it "can list all of an astronaut's missions" do
      matt = Astronaut.create!(name: "Matt", age: 12, job: "Spaceman")
      kara = Astronaut.create!(name: "Kara", age: 14, job: "Spacegorlmoonrockcollecter")

      apollo = Mission.create!(title: "The on Tom Hanks was on", time_in_space: 12)
      capricorn = Mission.create!(title: "The one they found corn", time_in_space: 20)
      gemini = Mission.create!(title: "Something about stars", time_in_space: 5)

      ast_space = AstronautMission.create!(astronaut_id: matt.id, mission_id: apollo.id)
      ast_space1 = AstronautMission.create!(astronaut_id: matt.id, mission_id: capricorn.id)
      ast_space2 = AstronautMission.create!(astronaut_id: matt.id, mission_id: gemini.id)

      ast_space3 = AstronautMission.create!(astronaut_id: kara.id, mission_id: apollo.id)
      ast_space4 = AstronautMission.create!(astronaut_id: kara.id, mission_id: capricorn.id)

      expect(matt.all_missions_sorted).to eq(["Something about stars", "The on Tom Hanks was on", "The one they found corn"])
      expect(kara.all_missions_sorted).to eq(["The on Tom Hanks was on", "The one they found corn"])
    end

    it "can determine an astronaut's total time in space" do
      matt = Astronaut.create!(name: "Matt", age: 12, job: "Spaceman")
      kara = Astronaut.create!(name: "Kara", age: 14, job: "Spacegorlmoonrockcollecter")

      apollo = Mission.create!(title: "The on Tom Hanks was on", time_in_space: 12)
      capricorn = Mission.create!(title: "The one they found corn", time_in_space: 20)
      gemini = Mission.create!(title: "Something about stars", time_in_space: 5)

      ast_space = AstronautMission.create!(astronaut_id: matt.id, mission_id: apollo.id)
      ast_space1 = AstronautMission.create!(astronaut_id: matt.id, mission_id: capricorn.id)
      ast_space2 = AstronautMission.create!(astronaut_id: matt.id, mission_id: gemini.id)

      ast_space3 = AstronautMission.create!(astronaut_id: kara.id, mission_id: apollo.id)
      ast_space4 = AstronautMission.create!(astronaut_id: kara.id, mission_id: capricorn.id)

      expect(matt.total_time_in_space).to eq(37)
      expect(kara.total_time_in_space).to eq(32)

      ast_space5 = AstronautMission.create!(astronaut_id: kara.id, mission_id: gemini.id)

      expect(kara.total_time_in_space).to eq(37)
    end
  end
end
