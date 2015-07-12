require 'spec_helper'

describe Map, type: :model do

  describe "Associations" do
    it { should have_many(:paths) }
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "creation" do

    context "valid attributes" do
      it "should be valid" do
        map = build(:map)
        map.should be_valid
      end
    end

    context "invalid attributes" do
      it "should not be valid" do
        map = build(:map, name: "")
        map.should_not be_valid
      end
    end
  end
end
