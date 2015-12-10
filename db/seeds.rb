newuser = User.create(provider: "Github", uid: "23", email: "example@gmail.com", username: "steve", avatar_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Ruby_logo.svg/100px-Ruby_logo.svg.png")
newuser1 = User.create(provider: "Github", uid: "24", email: "example@gmail.com", username: "brian", avatar_url: "http://kindersay.com/files/images/baseball.png")
one = Meetup.create(name: "Best one", location: "Launch Academy", description: "best meetup in town", creator: 1)
two = Meetup.create(name: "Best two", location: "Launch Academyy", description: "best meetup in townn", creator: 2)
three = Meetup.create(name: "A Best two", location: "chinatown", description: "and another one", creator: 1)

Membership.create(user: newuser, meetup: one)
Membership.create(user: newuser1, meetup: two)
Membership.create(user: newuser, meetup: three)
