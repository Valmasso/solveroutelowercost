require 'spec_helper'

require_relative '../../lib/parser'

describe Parser, type: :lib do

  describe ".parse_file" do
    context 'Input invalid' do
      it "raises InvalidInput" do
        expect { subject.parse_file(nil) }.to raise_error(Parser::InvalidInput)
      end
    end

    context 'Input valid' do
      let(:file) { txt_fixture("data") }
      let(:data_invalid) { txt_fixture("data_invalid") }
      let(:parsed_file) { subject.parse_file(file) }

      it "parse success" do
        expect(parsed_file.size).to eq(6)
        expect(parsed_file.first.from).to eq("D")
        expect(parsed_file.first.to).to eq("E")
        expect(parsed_file.first.distance.to_f).to eq(30.0)
        expect(parsed_file.first).to be_a(Path)
      end

      it "raises InvalidInput" do
        expect { subject.parse_file(data_invalid) }.to raise_error(Parser::InvalidInput)
      end
    end
  end

  describe ".parse_entry" do
    context 'Input invalid' do
      it "raises InvalidInput" do
        expect { subject.parse_entry(nil) }.to raise_error(Parser::InvalidInput)
      end
    end

    context 'Input valid' do
      let(:entry) { txt_fixture("entry") }
      let(:entry_invalid) { txt_fixture("entry_invalid") }
      let(:parsed_entry) { subject.parse_entry(entry) }

      it "parse success" do
        expect(parsed_entry.size).to eq(2)
        expect(parsed_entry.first).to be_a(Path)
        expect(parsed_entry.first.from).to eq("A")
        expect(parsed_entry.first.to).to eq("D")
        expect(parsed_entry.first.distance.to_f).to eq(10)
        expect(parsed_entry.last.to_f).to eq(2.5)
      end

      it "raises InvalidInput" do
        expect { subject.parse_entry(entry_invalid) }.to raise_error(Parser::InvalidInput)
      end
    end
  end
end
