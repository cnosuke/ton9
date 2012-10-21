require 'spec_helper'

describe UsersController do
  context "Userとしてsign_inしている" do
    describe :index do
      it "??として???が返されている"
      it 'users/indexをレンダリングする'
    end
  end
  context "Userとしてsign_inしていない" do
    describe :index do
      it "sign_inページにリダイレクトされる"
    end
  end
end
