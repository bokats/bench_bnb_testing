require 'rails_helper'

RSpec.describe Api::BenchesController, type: :controller do
  describe "GET #new" do
    let! (:bench) { create(:bench) }
    before(:each) do
      get :show, { id: bench.id, format: :json }
    end

    it { should render_template(:show) }
    it { should respond_with(200) }
  end
end
