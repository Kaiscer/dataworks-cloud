variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

variable "zone" {
  description = "zone"
}

# Variables used in cluster main
variable "gke_num_node" {
  description = "number of gke nodes"
}

variable "initial_node_count" {
  description = "The number of nodes to create in this cluster's default node pool"
}

variable "min_master_version" {
  description = "The minimum version of the master. GKE will auto-update the master to new versions"
}

variable "master_ipv4_cidr_block" {
  description = "This range will be used for assigning private IP addresses to the cluster master(s) and the ILB VIP. This range must not overlap with any other ranges in use within the cluster's network, and it must be a /28 subnet"
}

# Variables used in intaces 
variable "machine_type" {
  description = "vm-lnx type e2-micro" 
}

# Variables used in firewall
variable "direction" {
  description = "Direction of traffic to which this firewall applies; default is INGRESS"
}

variable "credentialfile" {
  
}