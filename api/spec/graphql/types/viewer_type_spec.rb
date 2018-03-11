require 'rails_helper'

RSpec.describe 'Types::ViewerType', type: :model do
  let(:query) { %Q|
query ViewerInfo { viewer {
  all_authors { totalCount }
  my_posts { totalCount }
  public_posts { totalCount }
  self { db_row_id id name email }
}}
| }

  let!(:context) do
    { current_user: viewer }
  end
  context 'when viewer is not logged in' do
    let(:viewer) { NullUser.new }

    describe 'query anonymous viewer info' do
      let(:results) { R5GraphqlReactSchema.execute(query, context: context) }

      it "should return a JSON date viewer object" do
        expect(results.dig('data','viewer')).not_to be_nil
      end

      it "should return viewer data for null user" do
        expected = {
          all_authors: { totalCount: 0 },
          my_posts: { totalCount: 0 },
          public_posts: { totalCount: 0 },
          self: { db_row_id: -1, id: '', name: '', email: ''}
        }.deep_stringify_keys

        expect(results.dig('data', 'viewer')).to eq(expected)
      end
    end
  end
  context 'when view is logged in' do
    let(:viewer) {FactoryGirl.create(:user)}
    describe 'query logged in viewer info' do
      let(:results) { R5GraphqlReactSchema.execute(query, context: context)}

      it "should return a JSON data viewer object" do
        expect(results.dig('data', 'viewer')).not_to be_nil
      end

      it "should return viewer data for the current user" do
        expected = {
          all_authors: { totalCount: 1 },
          my_posts: { totalCount: 0 },
          public_posts: { totalCount: 0 },
          self: { db_row_id: viewer.id, id: viewer.uuid, name: viewer.name, email: viewer.email }
        }.deep_stringify_keys

        expect(results.dig('data', 'viewer')).to eq(expected)
      end
    end
  end
end
