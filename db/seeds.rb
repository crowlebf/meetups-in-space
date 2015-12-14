newuser = User.create(provider: "Github", uid: "23", email: "example@gmail.com", username: "steve", avatar_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Ruby_logo.svg/100px-Ruby_logo.svg.png")
newuser1 = User.create(provider: "Github", uid: "24", email: "example@gmail.com", username: "lou", avatar_url: "http://kindersay.com/files/images/baseball.png")
one = Meetup.create(name: "Example 1", location: "Boston", description: "description of the first meetup", creator: 1)
two = Meetup.create(name: "Example 2", location: "Austin", description: "description of the second meetup", creator: 2)
three = Meetup.create(name: "Example 3", location: "Tampa", description: "description of the third meetup", creator: 1)

Membership.create(user: newuser, meetup: one)
Membership.create(user: newuser1, meetup: two)
Membership.create(user: newuser, meetup: three)
