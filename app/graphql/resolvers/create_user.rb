class Resolvers::CreateUser < GraphQL::Function
  argument :name, !types.String
  argument :authProvider, !Types::AuthProviderInput

  type Types::UserType

  def call(_obj, args, _ctx)
    User.create!(
      name: args[:name],
      email: args[:authProvider][:email],
      password: args[:authProvider][:password]
    )
  end
end
