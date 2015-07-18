require 'rails_helper'

describe MapsController, type: :controller do

  let(:options) { { format: :text } }

  describe "Record Not Found" do
    it { should rescue_from(ActiveRecord::RecordNotFound).with(:handle_not_found) }
  end

  describe "GET #index" do
    let(:map) { create(:map) }

    before { get :index, format: :text }

    it { should render_template('index') }

    it "assigns @maps" do
      expect(assigns(:maps)).to eq([map])
    end
  end

  describe "GET #show" do
    context 'Record Not Found' do
      before { get :show, id: "MyMap", format: :text }

      it { should respond_with(404) }
    end

    context 'Record Found' do
      let(:map) { create(:map) }

      before { get :show, id: map.name, format: :text }

      it { should render_template('show') }

      it "assigns @map" do
        expect(assigns(:map)).to eq(map)
      end
    end
  end

  describe "POST #create" do
    let(:map) { attributes_for(:map) }

    context "with valid params" do
      let(:data) { txt_fixture("data") }

      before do
        request.headers["RAW_POST_DATA"] = data
      end

      it "creates a new Map" do
        expect { post :create, id: map[:name] }.to change(Map, :count).by(1)
      end
    end

    context "with invalid params" do
      let(:data_invalid) { txt_fixture("data_invalid") }

      before do
        request.headers["RAW_POST_DATA"] = data_invalid
      end

      it "not creates a new Map" do
        expect { post :create, id: map[:name] }.to raise_error(Parser::InvalidInput)
      end
    end
  end

  describe "PUT #update" do

    context 'Record Not Found' do
      before { put :update, id: "MyMap" }

      it { should rescue_from(ActiveRecord::RecordNotFound) }
    end

    context 'Record Found' do
      let(:map) { create(:map_with_paths) }

      context "with valid params" do
        let(:data) { txt_fixture("data") }

        before do
          request.headers["RAW_POST_DATA"] = data
          put :update, id: map.name, format: :text
        end

        it "updates the requested map" do
          map.reload
          expect(map.paths.size).to eq(6)
          expect(map.paths.last.from).to eq("B")
          expect(map.paths.last.to).to eq("D")
          expect(map.paths.last.distance).to eq(15.00)
        end
      end

      context "with invalid params" do
        let(:data_invalid) { txt_fixture("data_invalid") }

        before do
          request.headers["RAW_POST_DATA"] = data_invalid
        end

        it "not updates the requested map" do
          expect { put :update, id: map.name }.to raise_error(Parser::InvalidInput)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:map) { create(:map) }

    it "destroys the requested map" do
      expect { delete :destroy, id: map.name, format: :text }.to change(Map, :count).by(-1)
    end
  end

  describe "POST #search" do
    let(:map) { create(:map) }

    context "with valid params" do
      let(:map) { attributes_for(:map) }
      let(:data) { txt_fixture("data") }
      let(:entry) { txt_fixture("entry") }

      before do
        request.headers["RAW_POST_DATA"] = data
        post :create, id: map[:name]
      end

      it "found shortest path" do
        request.headers["RAW_POST_DATA"] = entry
        post :search, id: map[:name], format: :text
        expect(assigns(:shortest_path)).to eq("A B D 6.25")
      end
    end

    context "with invalid params" do
      let(:map) { create(:map) }
      let(:entry_invalid) { txt_fixture("entry_invalid") }

      before do
        request.headers["RAW_POST_DATA"] = entry_invalid
      end

      it "not search" do
        expect { post :search, id: map.name }.to raise_error(Parser::InvalidInput)
      end
    end
  end
end
