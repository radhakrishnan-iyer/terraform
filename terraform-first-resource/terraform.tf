provider "github" {
  token = "<test>"
}

resource "github_repository" "terraform-first-repo" {
  name        = "first-repo-from-terraform"
  description = "This is my first repo created using terraform"
  visibility = "public"
  auto_init = true
}

resource "github_repository" "terraform-second-repo" {
  name        = "second-repo-from-terraform"
  description = "This is my second repo created using terraform"
  visibility = "public"
  auto_init = true
}