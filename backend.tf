terraform {
  backend "remote" {
    organization = "gr-devops-team"

    workspaces {
      name = "workspace-ec2"
    }
  }
}