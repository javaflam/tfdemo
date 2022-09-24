terraform {
  backend "local" {
    path = "/home/ubuntu/tfstate/terraform.tfstate"
  }
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.4.0"
    }
  }
}

resource "confluent_environment" "test_env" {
  display_name = "test_env"
}

resource "confluent_kafka_cluster" "basic" {
  display_name = "rv_cluster"
  availability = "SINGLE_ZONE"
  cloud        = "AWS"
  region       = "ap-southeast-1"
  basic {}
  environment {
    id = confluent_environment.test_env.id
  }
}
