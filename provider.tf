provider "google" {
credentials = "${file("..//gc_key_new.json")}"
project = "quick-charger-317515"
region = "us-central1"
}
