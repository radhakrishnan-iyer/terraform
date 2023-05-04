resource "github_repository" "terraform-first-repo" {
  name        = "first-repo-from-terraform"
  description = "This is my first repo created using terraform"
  visibility  = "public"
  auto_init   = true
}

output "terraform_github_url" {
  value = github_repository.terraform-first-repo.html_url
}