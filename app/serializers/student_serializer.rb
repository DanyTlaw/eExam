class StudentSerializer < ActiveModel::Serializer
  attributes :id, :email, :check, :online
end
