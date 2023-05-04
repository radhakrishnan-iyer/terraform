variable users {
    type = list
}

output hello {
    value = "The users are ${tostring(var.users)}"
}