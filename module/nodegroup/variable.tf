variable "cluster_name" {
    type = string
}
variable "EKS_NODEGROUP_ROLE_ARN" {}
variable "private_subnet_1_ids" {}
# variable "private_subnet_2_ids" {}
variable "worker_node_policy_attachment_id" {}
variable "amazoneks_cni_policy_attachment_id" {}
variable "container_registry_readonly_policy_attacment_id" {}
