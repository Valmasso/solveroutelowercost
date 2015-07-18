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

  describe "instance methods" do
    describe "#search_path" do
      let(:map) { create(:map_with_paths_defined) }
      let(:path) { build(:path, from: "A", to: "D", distance: 10) }
      let(:fuel) { 2.5 }

      it "result with 2 elements" do
        expect(map.search_path(path, fuel).size).to eq(2)
        expect(map.search_path(path, fuel)).to eq([["A", "B", "D"], 6.25])
      end
    end

    describe "#to_graph" do
      let(:map) { create(:map_with_paths_defined) }
      let(:result) do
        [
          ["D", "E", 30.0],
          ["A", "C", 20.0],
          ["C", "D", 30.0],
          ["A", "B", 10.0],
          ["B", "E", 50.0],
          ["B", "D", 15.0]
        ]
      end

      it "result with 6 elements" do
        expect(map.to_graph.size).to eq(6)
        expect(map.to_graph).to eq(result)
      end
    end

    describe "#to_show" do
      let(:map) { create(:map_with_paths_defined) }
      let(:result) do
        "[\"D\", \"E\", 30.0]\n[\"A\", \"C\", 20.0]\n[\"C\", \"D\", 30.0]\n[\"A\", \"B\", 10.0]\n[\"B\", \"E\", 50.0]\n[\"B\", \"D\", 15.0]"
      end

      it "result with success" do
        expect(map.to_show).to eq(result)
      end
    end
  end
end
