module Api
  module V1
    class UserSerializer
      include JSONAPI::Serializer
      attributes :id, :usernamename, :email 
    end
  end
end
  