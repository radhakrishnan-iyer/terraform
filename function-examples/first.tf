output printfirst {
    value = "${join("-->",var.users)}"
}

output upperCase {
    value = "${upper(var.users[0])}"
}