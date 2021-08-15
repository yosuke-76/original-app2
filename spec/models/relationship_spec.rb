require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:relationship) {FactoryBot.create(:relationship)}
  describe 'relationship' do
    context "保存ができる時" do
      it "全てのパラメーターが揃っていれば保存できる" do
        expect(relationship).to be_valid
      end
    end
    context "保存ができない時" do
      it "follow_idが空では保存出来ない" do
        relationship.follow_id = nil
        relationship.valid?
        expect(relationship.errors.full_messages).to include "Follow can't be blank"
      end
      it "user_idが空では保存できない" do
        relationship.user_id = nil
        relationship.valid?
        expect(relationship.errors.full_messages).to include "User can't be blank"
      end
    end

    context "一意性の検証" do
      before do
        @relation = FactoryBot.create(:relationship)
        @user1 = FactoryBot.build(:relationship)
      end
      it "follow_idとuser_idの組み合わせは一意でなければ保存できない" do
        relation2 = FactoryBot.build(:relationship, follow_id: @relation.follow_id, user_id: @relation.user_id)
        relation2.valid?
        expect(relation2.errors.full_messages).to include "Follow has already been taken"
      end
      it "user_idが違うなら保存ができる" do
        relation2 = FactoryBot.build(:relationship, follow_id: @relation.follow_id, user_id: @user1.user_id)
        relation2.valid?
        expect(relation2).to be_valid
      end
      it "follow_idが違うなら保存ができる" do
        relation2 = FactoryBot.build(:relationship, follow_id: @user1.follow_id, user_id: @relation.user_id)
        expect(relation2).to be_valid
      end
    end
  end
end