Types::AuthProviderInput = GraphQL::InputObjectType.define do
  name 'AUTH_PROVIDER'

  argument :email, !types.String
  argument :password, !types.String
end
