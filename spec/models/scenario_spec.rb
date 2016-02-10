require 'rails_helper'
def scenario_all
  Scenario.new(name: "Name",
	       vest_level: 100
  	      )
end

RSpec.describe Scenario, type: :model do
  before(:each) do
    @scene = scenario_all
  end

  it "should be valid" do
    expect(@scene).to be_valid
  end

  it "should have a name" do
    @scene.update(name: nil)
    expect(@scene).not_to be_valid
  end
  
  it "should have a non-blank name" do
    @scene.update(name: "   ")
    expect(@scene).not_to be_valid
  end
  
  it "should have a non-short name" do
    @scene.update(name: "x")
    expect(@scene).not_to be_valid
  end
end
