require 'rails_helper'

RSpec.describe Villain, type: :model do
  it "should validate name" do
    villain = Villain.create
    expect(villain.errors[:name]).to_not be_empty
  end
  it "should validate age" do
    villain = Villain.create
    expect(villain.errors[:age]).to_not be_empty
  end
  it "should validate enjoy" do
    villain = Villain.create
    expect(villain.errors[:enjoy]).to_not be_empty
  end
  it "should validate img" do
    villain = Villain.create
    expect(villain.errors[:img]).to_not be_empty
  end
  it "enjoy should be at least 10 characters long" do
    villain = Villain.create
    expect(villain.errors[:enjoy]).to_not be_empty
  end
end
