#create elements
catwalk = Element.create(name:"Catwalk")

#create ropes
green_details = {
  primary_color: "green",
  pcord_color: "black",
  element:catwalk
}
blue_details = {
  primary_color: "blue",
  pcord_color: "black",
  element:catwalk
}
green_rope = Rope.create(green_details)
blue_rope = Rope.create(blue_details)

#create a user
user_details = {
  fullname: "Chris Dalla Santa",
  username: "chris",
  password: "p"
}
User.create(user_details)
