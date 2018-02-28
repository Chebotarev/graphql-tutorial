# defines a new GraphQL type
Types::LinkType = GraphQL::ObjectType.define do
  # this type is named `Link`
  name 'Link'

  # it has the following fields
  field :id, !types.ID
  field :url, !types.String
  field :description, !types.String

  field :postedBy, -> { Types::UserType }, property: :user
  field :votes, !types[Types::VoteType]
end
