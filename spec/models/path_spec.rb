require 'spec_helper'

describe Path, type: :model do
  describe "Associations" do
    it { should belong_to(:map) }
  end

  describe "Validations" do
    it { should validate_presence_of(:from) }
    it { should validate_presence_of(:to) }
    it { should validate_numericality_of(:distance) }
    it { should validate_presence_of(:map) }
    it { should validate_uniqueness_of(:from).scoped_to([:to, :map_id]) }
    it { should validate_uniqueness_of(:to).scoped_to([:from, :map_id]) }
  end

  describe "creation" do

    context "valid attributes" do
      it "should be valid" do
        path = build(:path)
        path.should be_valid
      end
    end

    context "invalid attributes" do
      it "should not be valid" do
        path = build(:path, from: "")
        path.should_not be_valid
      end
    end
  end
end
