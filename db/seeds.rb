#create elements
catwalk = Element.create(name:"Catwalk")

#create ropes
green_details = {
  primary_color: "green",
  pcord_color: "black",
  total_climbs: 0
}
blue_details = {
  primary_color: "blue",
  pcord_color: "black",
  total_climbs: 0
}
green_rope = Rope.create(green_details)
blue_rope = Rope.create(blue_details)

#associate ropes with the catwalk
green_rope.update(element:catwalk)
blue_rope.update(element:catwalk)

#create a user
user_details = {
  name: "Chris Dalla Santa",
  username: "chris",
  password: "p"
}
User.create(user_details)
