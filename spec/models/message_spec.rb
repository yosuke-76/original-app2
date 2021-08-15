require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end
  describe 'message作成' do
    context "messageが送信できる時" do
      it "全ての情報が入力されていれば送信できる" do
        expect(@message).to be_valid
      end
    end
    context "messageが送信できない時" do
      it "contentが空だと送信できない" do
        @message.content = ''
        @message.valid?
        expect(@message.errors.full_messages).to include "Content can't be blank"
      end
      it "messageに紐づくuserがいないと送信できない" do
        @message.user = nil
        @message.valid?
        expect(@message.errors.full_messages).to include "User must exist"
      end
      it "messageに紐づくroomが無いと送信できない" do
        @message.room = nil
        @message.valid?
        expect(@message.errors.full_messages).to include "Room must exist"
      end
    end
  end
end
