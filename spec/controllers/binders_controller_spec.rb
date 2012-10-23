# coding: utf-8
require 'spec_helper'

describe BindersController do
  let(:binder_attributes) {{:binder => attributes_for(:binder)}}
  
  context "userとしてログインしているとき" do
    let(:user) {create :user}
    before {sign_in user}

    describe :create do

      context "jsonリクエスト成功時" do

        describe "データベース操作" do

          it "Binderが作成されている" do
            expect{
              post :create, binder_attributes, :format => :json
            }.to change{ Binder.count }.by(1)
          end

          it "作成されたBinderは作成者からアクセス権がある" do
            post :create, binder_attributes, :format => :json
            Binder.last.users.should include(user)
          end

        end # データベース関係

        describe "Jsonデータ" do
          before {post :create, binder_attributes, :format => :json}
          subject {JSON.parse(response.body)}

          it "resultとして1が返される" do
            should include(:result => 1)
          end

          it "dataとしてbinderデータが返される" do
            should include(:data => Binder.last.to_json)
          end

        end #Jsonデータ

      end # jsonリクエスト成功時

      context "jsonリクエスト失敗時" do
        before do
          Binder.any_instance.stub(:save).and_return(false)
        end

        describe "データベース操作関係" do
          it "Binderが作成されていない" do
            expect{
              post :create, binder_attributes, :format => :json
            }.to_not change{ Binder.count }
          end
        end
        describe "Jsonデータ" do
          before {post :create, binder_attributes, :format => :json}
          subject {JSON.parse(response.body)}

          it "resultとして0が返される" do
            should include(:result => 0)
          end
          it "messageとして'Binder save faild.'が返される" do
            should include(:message => 'Binder save faild.')
          end
          it "dataはない" do
            should_not include(:data)
          end
        end
      end
    end

    describe :add_documents do
      context "(Binder)bに入っていない∧(User)current_userが管理している(Document)dのとき" do
        describe "データベース操作" do
          it "DocumentがBinderに追加される"
        end
        describe "Jsonデータ" do
          it "resultとして1が返される"
          it "dataとしてbinderデータが返される"
        end
      end

      context "(Binder)bに入っている∧(User)current_userが管理している(Docment)dのとき" do
        describe "データベース操作" do
          it "DocumentがBinderに追加されない"
        end
        describe "Jsonデータ" do
          it "resultとして0が返される"
          it "messageとして'Document already included in Binder.'が返される"
          it "dataとしてbinderデータが返される"
        end
      end

      context "(User)current_userが管理していない(Docment)dのとき" do
        describe "データベース操作" do
          it "DocumentがBinderに追加されない"
        end
        describe "Jsonデータ" do
          it "resultとして0が返される"
          it "messageとして'The Document is not managed by CurrentUser.'が返される"
          it "dataとしてbinderデータが返される"
        end
      end

      context "Binderのvalidation error時" do
        describe "データベース操作" do
          it "DocumentがBinderに追加されない"
        end
        describe "Jsonデータ" do
          it "resultとして0が返される"
          it "messageとして'Binder save faild.'が返される"
          it "dataはない"
        end
      end
    end
  end

  context "userとしてログインしていないとき" do
    describe :create do
      describe "データベース操作関係" do
        it "Binderが作成されていない"
      end
      describe "Jsonデータ" do
        it "resultとして0が返される"
        it "messageとして'Please sign_in.'が返される"
        it "dataはない"
      end
    end
    describe :add_documents do
      describe "データベース操作" do
        it "DocumentがBinderに追加されない"
      end
      describe "Jsonデータ" do
        it "resultとして0が返される"
        it "messageとして'Please sign_in.'が返される"
        it "dataはない"
      end
    end
  end
end
