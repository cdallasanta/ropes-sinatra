#create elements
catwalk = Element.create(name:"Catwalk")
pirates_crossing = Element.create(name:"Pirate's Crossing")

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

red_details = {
  primary_color: "red",
  pcord_color: "white",
  element:pirates_crossing
}
orange_details = {
  primary_color: "orange",
  pcord_color: "white",
  element:pirates_crossing
}
red_rope = Rope.create(red_details)
orange_rope = Rope.create(orange_details)

#create a user
user_details = {
  fullname: "Chris Dalla Santa",
  username: "chris",
  password: "p"
}
User.create(user_details)
