# coding: utf-8
require 'spec_helper'
require 'pp'

describe BindersController do
  let(:binder_attributes) {{:binder => attributes_for(:binder)}}

  describe :create do
    context %Q(userとしてsign_inしている時) do
      before do
        @user = create :user
        sign_in @user
      end

      it %Q{(TT)sign_inしている} do
        controller.user_signed_in?.should eq(true)
        controller.current_user.should eq(@user)
      end # TT sign_in

      context %Q(jsonリクエスト時) do

        before do
          request.env["HTTP_ACCEPT"] = "application/json"
        end

        describe %Q{TT} do
          define_dummy_controller :create

          it "(TT)jsonリクエストになる" do
            post :create
            response.content_type.should eq("application/json")
          end
        end # TT jsonリクエスト

        context %Q(バリデーションが通った時) do
          it "(TT)binder_attributesは正当なBinderのアトリビュート" do
            Binder.new(binder_attributes[:binder]).should be_valid
          end
          
          it "status = 200" do
            post :create, binder_attributes
            response.status.should eq(200)
          end

          it "Binderが作成される" do
            expect {
              post :create, binder_attributes
            }.to change{ Binder.count }.by(1)
          end 

          it "新しいBinderは現在のユーザに権限がある" do
            post :create, binder_attributes
            Binder.last.users.should include(@user)
          end

          describe "jsonデータ" do
            before do
              post :create, binder_attributes
            end
            subject {JSON.parse(response.body)}

            it ":result => 1" do
              should include("result" => 1)
            end
            it ":data => Binderデータ" do
              should include("data" => JSON.parse(Binder.last.to_json))
            end
          end # jsonデータ
        end # バリデーションが通った時

        context %Q(バリデーションが通らなかった時) do
          before do
            Binder.any_instance.stub(:save).and_return(false)
          end

          it "(TT)強制的にvalidation error" do
            Binder.new(binder_attributes[:binder]).save.should be_false
          end
          
          it "status = 200" do
            post :create, binder_attributes
            response.status.should eq(200)
          end

          it "Binderが作成されない" do
            expect {
              post :create, binder_attributes
            }.to_not change{ Binder.count }
          end

          describe "jsonデータ" do
            before do
              post :create, binder_attributes
            end
            subject {JSON.parse(response.body)}

            it ":result => 0" do
              should include("result" => 0)
            end
            it ":message => 'Binder save faild.'" do
              should include("message" => 'Binder save faild.')
            end
          end # jsonデータ
        end # バリデーションが通らなかった時

      end# jsonリクエスト時

      context %Q(htmlリクエスト時) do
        describe %Q{TT} do
          define_dummy_controller :create

          it "(TT)htmlリクエストになる" do
            post :create
            response.content_type.should eq("text/html")
          end
        end # TT
        
        it "status = 406" do
          post :create, binder_attributes
          response.status.should eq(406)
        end

        it "Binderが作成されない" do
        expect {
          post :create, binder_attributes
        }.to_not change{ Binder.count }
        end
      end # htmlリクエスト
    end # userとしてsign_inしている時

    context %Q(userとしてsign_inしていない時) do

      it %Q{(TT)sign_inしていない} do
        controller.user_signed_in?.should eq(false)
      end # TT sign_inしていない

      it "status = 200" do
        post :create, binder_attributes
        response.status.should eq(200)
      end

      it "Binderが作成されない" do
        expect {
          post :create, binder_attributes
        }.to_not change{ Binder.count }
      end

      describe "jsonデータ" do
        before do
          post :create, binder_attributes
        end
        subject {JSON.parse(response.body)}

        it ":result => 0" do
          should include("result" => 0)
        end
        it ":message => 'Please sign_in.'" do
          should include("message" => 'Please sign_in.')
        end
      end # jsonデータ
    end # userとしてsign_inしていない時
  end

  describe :add_documents do
    pending "保留"
  end

  describe :index do
    pending "保留"
  end

end
