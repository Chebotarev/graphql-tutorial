Types::UserType = GraphQL::ObjectType.define do
  name 'User'

  field :id, !types.ID
  field :name, !types.String
  field :email, !types.String

  field :votes, !types[Types::VoteType]
end
