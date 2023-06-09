
#  Cluster - GCP
resource "google_container_cluster" "main" {
  name                     = var.project_id
  initial_node_count       = var.initial_node_count
  location                 = var.region
  network                  = "${var.project_id}-vpc"
  subnetwork               = "${var.project_id}-subnet"
  remove_default_node_pool = true
  enable_legacy_abac       = true
  min_master_version       = var.min_master_version


  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "10.0.10.0/28"
  }

  ip_allocation_policy {

  }
}

resource "google_container_node_pool" "second_node" {
  name       = google_container_cluster.main.name
  location   = var.region
  cluster    = google_container_cluster.main.name
  node_count = var.gke_num_node

  node_config {

    labels = {
      env = var.project_id
    }
    tags = ["gke-node", "${var.project_id}-gke"]
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

  }

}

resource "google_compute_instance" "vm-lnx-01" {
  name         = "vm-lnx-01"
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"

    }
  }

  network_interface {
    network    = "${var.project_id}-vpc"
    subnetwork = "${var.project_id}-subnet"
    access_config {
      nat_ip = google_compute_address.vm-lnx-01-ip.address
    }
  }

  metadata = {
    disable-legacy-endpoint = true
  }
}

resource "google_compute_address" "vm-lnx-01-ip" {

  name = "vm-lnx-01-ip"

}

resource "google_compute_firewall" "ssh" {

  name    = "vcp-allow-ssh"
  network = "${var.project_id}-vpc"
  direction = var.direction
  allow {
    protocol = "tcp"
    ports    = ["22"]

  }
  source_ranges = ["0.0.0.0/0"]

}
